const User = require("../models/User");

module.exports = {
  async index(request, response) {
    const user = await User.findAll();
    return response.json(user);
  },

  async store(request, response){
    const { name, cpf, birth } = request.body;
    const checkCpf = await User.findOne({where: {cpf}});
    if(checkCpf){      
      return response.status(401).send({msg: "cpf já cadastrado"});
    }
    const user = await User.create(
      {
        name,
        cpf,
        birth
      }
    );    
    return response.json(user);
  }
  
}