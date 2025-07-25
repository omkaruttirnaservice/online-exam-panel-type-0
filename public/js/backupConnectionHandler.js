window.addEventListener('load', function () {
    let backupInterval = null;
    let isBackupServerConnected = false;
    let retryCount = 0;
    const maxBackupConnectionRetry = 5;
    const backupConnectionCheckIntervalTimer = 2000;

    const messageBoxEl = $('.message-box');
    // const connectBackupServerBtnEl = $('#connect-backup-server');

    function checkBackupConnectedOrNot() {
        $.ajax({
            url: '/check-connection',
            type: 'GET',
            success: function (data) {
                console.log(data);
                isBackupServerConnected = data?.status || false;
                // messageBoxEl.text(data.status ? 'Connected' : 'Not connected');
                // connectBackupServerBtnEl.text(data.status ? 'Connected' : 'Connect');
                // connectBackupServerBtnEl.attr('disabled', data.status);

                setStatus(data.status);
                if (!data.status) {
                    retryCount++;
                }
            },
            error: function (error) {
                retryCount++;
                setStatus(false);
                // connectBackupServerBtnEl.attr('disabled', false);
                // connectBackupServerBtnEl.text('Connect');
            },
        });
    }

    $(document).on('keyup', '#backup-ip-input', function () {
        clearInterval(backupInterval);
        // connectBackupServerBtnEl.attr('disabled', false);
        // connectBackupServerBtnEl.text('Connect');

        setStatus(false);
    });

    backupInterval = setInterval(() => {
        console.log('Running interval');
        if (retryCount == maxBackupConnectionRetry) {
            clearInterval(backupInterval);
            // connectBackupServerBtnEl.attr('disabled', false);
            // connectBackupServerBtnEl.text('Connect');

            setStatus(false);
            return;
        }
        if (!backupInterval) return;
        checkBackupConnectedOrNot();
    }, backupConnectionCheckIntervalTimer);

    // javascript on login page
    $(document).on('click', '#connect-backup-server', function () {
        const thisBtn = $(this);
        let backupIP = $('#backup-ip-input').val();

        if (backupIP.trim() == '') {
            alert('Please enter valid backup server IP');
            return;
        }

        thisBtn.attr('disabled', true);
        thisBtn.text('Connecting...');

        $.ajax({
            url: '/connect-backup-server',
            type: 'POST',
            data: {
                backup_ip: 'http://' + backupIP,
            },
            success: function (data) {
                thisBtn.attr('disabled', false);
                thisBtn.text('Connect');
                clearMessage();
                console.log(data);
                messageBoxEl.html(`<p>${data.message}</p>`);
                if (data.call == 0) {
                    return;
                }
            },
            error: function (error) {
                thisBtn.attr('disabled', false);
                thisBtn.text('Connect');
                messageBoxEl.html(`<p>${error?.message || 'Not able to connect'}</p>`);
                clearMessage();
            },
        });
    });

    function setStatus(status) {
        $('.message-box').text(status ? 'Connected' : 'Disconnected');
        $('#backup-server-status-navbar').text(status ? 'Connected' : 'Disconnected');
        $('#connect-backup-server').text(status ? 'Connected' : 'Connect');
        $('#connect-backup-server').attr('disabled', status);
    }

    function clearMessage() {
        setTimeout(() => {
            messageBoxEl.html(`<p></p>`);
        }, 2500);
    }
});
