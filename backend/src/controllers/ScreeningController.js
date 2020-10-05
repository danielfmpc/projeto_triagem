const Screening = require("../models/Screening");

module.exports = {
  async index(request, response) {
    //const io = request.app.get('socket.io');
    // const nsp = io.of('/screenings');
    // nsp.on('connection', (socket)=>{
    //   socket.on('greeting', (msg) =>{
    //     nsp.emit('greeting',msg);
    //     console.log("user"+msg);
    //   });
    //   console.log(socket.id);
    // });
    const screen = await Screening.findAll();
    return response.json(screen);
  },

  async store(request, response){
    const { screening, status, ip } = request.body;
    const checkScreening = await Screening.findOne({where: {screening}});
    const checkIp = await Screening.findOne({where: {ip}});
    if(checkScreening){      
      return response.status(401).send({msg: "Triagem já cadastrada"});
    }
    if(checkIp){      
      return response.status(401).send({msg: "IP já cadastrado"});
    }
    const screen = await Screening.create(
      {
        screening,
        status,
        ip
      }
    );    
    return response.json(screen);
  }
  
}