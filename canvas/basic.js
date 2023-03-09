var canvas = document.querySelector('#canvas');
var ctx = canvas.getContext('2d');
// 点阵数字
var num0 = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 1, 0, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 0, 1, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0]
];
var num1 = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0],
    [0, 1, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 1, 1, 1, 1, 1, 0],
    [0, 0, 0, 0, 0, 0, 0]
];
var num2 = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 1, 0, 0],
    [0, 1, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0],
    [0, 1, 1, 1, 1, 1, 0],
    [0, 0, 0, 0, 0, 0, 0]
];
// 画线
var drawLine = function () {
    ctx.lineCap = 'round';
    ctx.beginPath();
    ctx.moveTo(10, 100);
    ctx.lineTo(100, 100);
    ctx.lineWidth = 8;
    ctx.strokeStyle = '#00ff00';
    ctx.stroke();
};
// 画圆弧
var percent = 0;
var drawArc = function () {
    percent = percent === 100 ? 0 : ++percent;
    if (percent === 0) {
        ctx.clearRect(0, 0, 400, 400);
        drawLine();
        ctx.stroke();
    }
    ctx.beginPath();
    ctx.arc(200, 200, 30, 0, 2 * Math.PI * percent / 100);
    ctx.lineWidth = 4;
    ctx.strokeStyle = '#ffff00';
    ctx.stroke();
    window.requestAnimationFrame(drawArc);
};
// 绘制点阵
var drawPoint = function () {
    var arr = [num0, num1, num2][Math.floor(Math.random() * 3)];
    ctx.clearRect(0, 0, 180, 200);
    for (var i = 0; i < arr.length; i++) {
        for (var j = 0; j < arr[i].length; j++) {
            if (arr[i][j] === 1) {
                ctx.beginPath();
                ctx.fillStyle = '#00ff00';
                ctx.arc((j + 1) * 22, (i + 1) * 20, 8, 0, 2 * Math.PI);
                ctx.fill();
                ctx.closePath();
            }
            else {
                ctx.beginPath();
                ctx.strokeStyle = '#fff';
                ctx.arc((j + 1) * 22, (i + 1) * 20, 8, 0, 2 * Math.PI);
                ctx.stroke();
                ctx.closePath();
            }
        }
    }
};
// drawLine()
// drawArc()
// drawLine()
setInterval(function () {
    drawPoint();
}, 1000);
