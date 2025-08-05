window.addEventListener('load', function () {
    let backupInterval = null;
    let isBackupServerConnected = false;
    let retryCount = 0;
    const maxBackupConnectionRetry = 5;
    const backupConnectionCheckIntervalTimer = 2000;

    const messageBoxEl = $('.message-box');

    // initially set status
    setStatus(isBackupServerConnected);

    // start the interval to check connection
    runCheckConnectionInterval();

    function runCheckConnectionInterval() {
        backupInterval = setInterval(() => {
            console.log('Running interval');
            if (retryCount == maxBackupConnectionRetry) {
                clearInterval(backupInterval);
                setMessage('Max retry count reached');
                setStatus(false);
                return;
            }
            if (!backupInterval) return;
            checkBackupConnectedOrNot();
        }, backupConnectionCheckIntervalTimer);
    }

    function checkBackupConnectedOrNot() {
        $.ajax({
            url: '/check-connection',
            type: 'GET',
            success: function (data) {
                console.log(data);
                setMessage(data.message);
                if (!data.backupConnectedIP || !data.status) {
                    setStatus(false);
                    clearInterval(backupInterval);
                    retryCount++;
                } else if (data.backupConnectedIP || data.status) {
                    setStatus(true);
                }
                const ip = data?.backupConnectedIP?.replace('http://', '') || '';
                $('#backup-ip-display').text(ip);
                $('#backup-ip-input').val(ip);
                isBackupServerConnected = data?.status || false;
            },
            error: function (error) {
                setMessage('Retrying to connect...');
                retryCount++;
                setStatus(false);
            },
        });
    }

    // javascript on login page
    $(document).on('click', '#connect-backup-server', function () {
        clearInterval(backupInterval);
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
                runCheckConnectionInterval();
                thisBtn.attr('disabled', false);
                thisBtn.text('Connect');
                // clearMessage();
                console.log(data);
                setMessage(data.message);
                // messageBoxEl.html(`<p>${data.message}</p>`);
                if (data.call == 0) {
                    return;
                }
            },
            error: function (error) {
                thisBtn.attr('disabled', false);
                thisBtn.text('Connect');
                setMessage(error?.message || 'Not able to connect');
                // messageBoxEl.html(`<p>${error?.message || 'Not able to connect'}</p>`);
                // clearMessage();
            },
        });
    });

    function setStatus(status) {
        $('.status-box').text(status ? 'Connected' : 'Disconnected');
    }

    function setMessage(status) {
        let date = new Date();

        $('.message-box').append(
            `<p>[${date.toLocaleDateString()} | ${date.toLocaleTimeString()}] ${status} </p>`
        );

        const messageBox = document.querySelector('.message-box');
        if (messageBox) {
            messageBox.scrollTop = messageBox.scrollHeight;
        }
    }

    function clearMessage() {
        setTimeout(() => {
            messageBoxEl.html(`<p></p>`);
        }, 2500);
    }

    $(document).on('click', '#restore-db-btn', function () {
        const thisBtn = $(this);
        const formData = new FormData();

        $('#restore-db-btn').attr('disabled', false);
        let file = document.getElementById('restore-db-file').files[0];
        if (!file) {
            alert('Please select file to restore');
            return;
        }
        thisBtn.attr('disabled', true);
        thisBtn.text('Restoring');
        formData.set('backup_file', file);
        console.log(file);

        // clearing up the backupinterval
        clearInterval(backupInterval);

        // restore backup functionality
        $.ajax({
            url: '/restore',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {
                thisBtn.attr('disabled', false);
                thisBtn.text('Restore');
                console.log(data);
                alert(data?.message || 'Restore successful');
            },
            error: function (error) {
                thisBtn.attr('disabled', false);
                thisBtn.text('Restore');
                console.log(error);
            },
        });
    });
});
