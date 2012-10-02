function device() {
}

device.GetTimestamp = function() {
    var ts = Math.round((new Date()).getTime() / 1000);
    return ts;
}

device.OpenUrl = function(url) {
    window.open(url);
};
