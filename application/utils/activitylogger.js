
const examActivityModel = require("../model/examactivityModel.js");

const getClientIp = (req) => {
    let ip = req.headers['x-forwarded-for'] ||
        req.connection.remoteAddress ||
        req.socket.remoteAddress ||
        (req.connection.socket ? req.connection.socket.remoteAddress : null);


    if (ip && ip.includes('::ffff:')) {
        ip = ip.split(':').pop();
    }
    return ip;
};

const activityLogger = {
    /**
     * Centralized logging function — writes directly to DB (no RabbitMQ)
     * @param {Object} req        - Express request object
     * @param {Object} pool       - Database pool
     * @param {string} actionType - Activity type constant
     * @param {string} message    - Descriptive message
     * @param {Object} customData - Any extra fields to override or add
     */
    log: async (req, pool, actionType, message, customData = {}) => {
        try {
            if (!pool) return;

            const ip = getClientIp(req);
            const mac = req.query.mac || req.body.mac || customData.mac_address || null;

            const session = req.session || {};
            const studentInfo = session.StudentInfo || {};
            const examInfo = session.Exam || {};

            const logData = {
                student_id: customData.student_id || studentInfo.sl_id || studentInfo.id || customData.id || null,

                student_name: customData.student_name || (
                    studentInfo.sl_f_name
                        ? `${studentInfo.sl_f_name} ${studentInfo.sl_l_name}`
                        : (studentInfo.student_name || customData.name || null)
                ),

                roll_no: customData.roll_no || studentInfo.sl_roll_number || studentInfo.roll_no || customData.id || null,

                batch_id: customData.batch_id || studentInfo.sl_batch_no || examInfo.tm_allow_to || customData.batch || null,
                exam_id: customData.exam_id || examInfo.exam_orignal_id || null,
                published_id: customData.published_id || examInfo.published_id || null,
                exam_name: customData.exam_name || examInfo.mt_name || examInfo.exam_name || null,
                lab_name: customData.lab_name || studentInfo.lab_name || studentInfo.lab_no || null,

                session_id: req.sessionID || null,
                action_type: actionType,
                message: message,

                question_id: customData.question_id || customData.q_id || null,
                question_no: customData.question_no || (
                    customData.q_index !== undefined
                        ? Number(customData.q_index) + 1
                        : (customData.to_q || customData.to || null)
                ),

                selected_option: customData.selected_option || customData.user_ans || null,

                answer_snapshot: customData.answer_snapshot
                    ? JSON.stringify(customData.answer_snapshot)
                    : JSON.stringify(customData),

                extra_data: (() => {
                    const cleanData = { ...customData };
                    const removeKeys = [
                        'student_id', 'roll_no', 'exam_id', 'published_id',
                        'action_type', 'message', 'question_id', 'question_no',
                        'selected_option', 'answer_snapshot', 'from_q', 'to_q',
                        'pc_label', 'mac_address', 'ip_address', 'attempt_no',
                        'total_questions', 'attempted', 'duration_mins'
                    ];
                    removeKeys.forEach(k => delete cleanData[k]);
                    return Object.keys(cleanData).length > 0 ? JSON.stringify(cleanData) : null;
                })(),

                from_q: customData.from_q || customData.from || null,
                to_q: customData.to_q || customData.to || null,

                pc_label: (customData.pc_label && customData.pc_label !== "-" && customData.pc_label !== "")
                    ? customData.pc_label
                    : (studentInfo.pc_no && studentInfo.pc_no !== "-"
                        ? studentInfo.pc_no
                        : (studentInfo.pc_label || null)),

                old_pc: customData.old_pc || null,
                new_pc: customData.new_pc || null,
                link_id: customData.link_id || null,

                mac_address: mac,
                ip_address: ip,

                attempt_no: customData.attempt_no || examInfo.mt_attempt_no || null,
                total_questions: customData.total_questions || examInfo.mt_total_test_question || null,
                attempted: customData.attempted || null,
                duration_mins: customData.duration_mins || (customData.exam_remaining_time?.min ?? null)
            };

            await examActivityModel.addLog(pool, logData);

            console.log(`[ActivityLogger] Saved: ${actionType} | roll: ${logData.roll_no}`);

        } catch (error) {
            console.error("[ActivityLogger] Failed:", error.message);
        }
    }
};

module.exports = activityLogger;