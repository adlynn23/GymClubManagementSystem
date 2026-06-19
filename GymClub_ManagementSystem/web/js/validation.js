function requireDateOrder(startId, endId, message) {
    const start = document.getElementById(startId);
    const end = document.getElementById(endId);
    if (!start || !end) return true;
    if (start.value && end.value && end.value <= start.value) {
        alert(message);
        end.focus();
        return false;
    }
    return true;
}

function requirePositiveNumber(id, message) {
    const input = document.getElementById(id);
    if (!input) return true;
    if (Number(input.value) <= 0) {
        alert(message);
        input.focus();
        return false;
    }
    return true;
}
