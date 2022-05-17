const myServiceDemo = function (srv) {
    srv.on('myfunction', (req, res) => {
        return "Hello " + req.data.msg;
    });
    
}

module.exports = myServiceDemo;