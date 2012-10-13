function Device() {
}

Device.GetTimestamp = function() {
    var ts = Math.round((new Date()).getTime() / 1000);
    return ts;
}

Device.OpenUrl = function(url) {
    window.open(url);
};
