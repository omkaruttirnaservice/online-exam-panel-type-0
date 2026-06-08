
// const examActivityModel = {
//     /**
//      * Insert a new log entry into exam_activity_log table
//      * @param {Object} pool - DB Pool
//      * @param {Object} data - Log data fields
//      */
//     addLog: async (pool, data) => {
//         const query = `
//             INSERT INTO exam_activity_log 
//             (
//                 student_id, student_name, roll_no, 
//                 batch_id, exam_id, published_id, exam_name, lab_name,
//                 session_id, action_type, message, 
//                 question_id, question_no, 
//                 selected_option, answer_snapshot, extra_data,
//                 from_q, to_q, pc_label, old_pc, new_pc, 
//                 link_id, mac_address, ip_address, 
//                 attempt_no, total_questions, attempted, duration_mins
//             ) 
//             VALUES (?,  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//         `;

//         const values = [
//             data.student_id || null,

//             data.student_name || null,
//             data.roll_no || null,
//             data.batch_id || null,
//             data.exam_id || null,
//             data.published_id || null,
//             data.exam_name || null,
//             data.lab_name || null,
//             data.session_id || null,
//             data.action_type || 'unknown',
//             data.message || '',
//             data.question_id || null,
//             data.question_no || null,
//             data.selected_option || null,
//             data.answer_snapshot || null,
//             data.extra_data || null,
//             data.from_q || null,
//             data.to_q || null,
//             data.pc_label || null,
//             data.old_pc || null,
//             data.new_pc || null,
//             data.link_id || null,
//             data.mac_address || null,
//             data.ip_address || null,
//             data.attempt_no || null,
//             data.total_questions || null,
//             data.attempted || null,
//             data.duration_mins || null
//         ];

//         try {
//             return await runQuery(pool, query, values);
//         } catch (error) {
//             console.error("Error inserting into exam_activity_log:", error);
//             return null;
//         }
//     },
//     // addBulkLogs: async (promisePool, logs) => {
//     //     const q = `
//     //         INSERT INTO exam_activity_log 
//     //         (
//     //             student_id,  student_name, roll_no, 
//     //             batch_id, exam_id, published_id, exam_name, lab_name,
//     //             session_id, action_type, message, 
//     //             question_id, question_no, 
//     //             selected_option, answer_snapshot, extra_data,
//     //             from_q, to_q, pc_label, old_pc, new_pc, 
//     //             link_id, mac_address, ip_address, 
//     //             attempt_no, total_questions, attempted, duration_mins
//     //         ) 
//     //         VALUES ?
//     //     `;

//     //     const values = logs.map((log) => [
//     //         log.student_id || null,

//     //         log.student_name || null,
//     //         log.roll_no || null,
//     //         log.batch_id || null,
//     //         log.exam_id || null,
//     //         log.published_id || null,
//     //         log.exam_name || null,
//     //         log.lab_name || null,
//     //         log.session_id || null,
//     //         log.action_type || 'unknown',
//     //         log.message || '',
//     //         log.question_id || null,
//     //         log.question_no || null,
//     //         log.selected_option || null,
//     //         log.answer_snapshot || null,
//     //         log.extra_data || null,
//     //         log.from_q || null,
//     //         log.to_q || null,
//     //         log.pc_label || null,
//     //         log.old_pc || null,
//     //         log.new_pc || null,
//     //         log.link_id || null,
//     //         log.mac_address || null,
//     //         log.ip_address || null,
//     //         log.attempt_no || null,
//     //         log.total_questions || null,
//     //         log.attempted || null,
//     //         log.duration_mins || null
//     //     ]);

//     //     return await promisePool.query(q, [values]);
//     // },

//     /**
//      * Advanced logActivity helper that auto-fills data from request session
//      */
//     logActivity: async (pool, req, actionType, message, extraData = null) => {
//         try {
//             // Get IP Address
//             const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress;

//             // Extract student data from session (Adjust keys based on your session structure)
//             const sessionData = req.session || {};
//             const studentData = sessionData.studentData || {};

//             const logData = {
//                 student_id: studentData.sl_id || sessionData.student_id || null,
//                 student_name: studentData.sl_full_name || sessionData.student_name || null,
//                 roll_no: studentData.sl_roll_number || sessionData.roll_no || null,
//                 batch_id: studentData.sl_batch_id || sessionData.batch_id || null,
//                 exam_id: sessionData.exam_id || null,
//                 published_id: sessionData.published_id || null,
//                 exam_name: sessionData.exam_name || null,
//                 session_id: req.sessionID || null,
//                 action_type: actionType,
//                 message: message,
//                 extra_data: extraData ? JSON.stringify(extraData) : null,
//                 ip_address: ip
//             };

//             return await examActivityModel.addLog(pool, logData);
//         } catch (error) {
//             console.error("Advanced Logging Error:", error);
//             return null;
//         }
//     }
// };

// module.exports = examActivityModel;


const examActivityModel = {
    /**
     * Insert a new log entry into exam_activity_log table
     * @param {Object} pool - DB Pool
     * @param {Object} data - Log data fields
     */
    addLog: (pool, data) => {
        return new Promise((resolve, reject) => {
            const query = `
                INSERT INTO exam_activity_log 
                (
                    student_id, student_name, roll_no, 
                    batch_id, exam_id, published_id, exam_name, lab_name,
                    session_id, action_type, message, 
                    question_id, question_no, 
                    selected_option, answer_snapshot, extra_data,
                    from_q, to_q, pc_label, old_pc, new_pc, 
                    link_id, mac_address, ip_address, 
                    attempt_no, total_questions, attempted, duration_mins
                ) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            `;

            const values = [
                data.student_id || null,
                data.student_name || null,
                data.roll_no || null,
                data.batch_id || null,
                data.exam_id || null,
                data.published_id || null,
                data.exam_name || null,
                data.lab_name || null,
                data.session_id || null,
                data.action_type || 'unknown',
                data.message || '',
                data.question_id || null,
                data.question_no || null,
                data.selected_option || null,
                data.answer_snapshot || null,
                data.extra_data || null,
                data.from_q || null,
                data.to_q || null,
                data.pc_label || null,
                data.old_pc || null,
                data.new_pc || null,
                data.link_id || null,
                data.mac_address || null,
                data.ip_address || null,
                data.attempt_no || null,
                data.total_questions || null,
                data.attempted || null,
                data.duration_mins || null
            ];

            pool.query(query, values, (err, result) => {
                if (err) {
                    console.error("Error inserting into exam_activity_log:", err);
                    return reject(err);
                }

                resolve(result);
            });
        });
    },

    /**
     * Advanced logActivity helper that auto-fills data from request session
     */
    logActivity: async (pool, req, actionType, message, extraData = null) => {
        try {
            const ip =
                req.headers['x-forwarded-for'] ||
                req.connection.remoteAddress ||
                req.socket.remoteAddress;

            const sessionData = req.session || {};
            const studentData = sessionData.studentData || {};

            const logData = {
                student_id: studentData.sl_id || sessionData.student_id || null,
                student_name: studentData.sl_full_name || sessionData.student_name || null,
                roll_no: studentData.sl_roll_number || sessionData.roll_no || null,
                batch_id: studentData.sl_batch_id || sessionData.batch_id || null,
                exam_id: sessionData.exam_id || null,
                published_id: sessionData.published_id || null,
                exam_name: sessionData.exam_name || null,
                session_id: req.sessionID || null,
                action_type: actionType,
                message: message,
                extra_data: extraData ? JSON.stringify(extraData) : null,
                ip_address: ip
            };

            return await examActivityModel.addLog(pool, logData);

        } catch (error) {
            console.error("Advanced Logging Error:", error);
            return null;
        }
    }
};

module.exports = examActivityModel;