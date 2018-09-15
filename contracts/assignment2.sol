pragma solidity ^0.4.19;

contract abc {
  
    address manager;
  
  struct User {
      string name;
      uint score;
  }
  
  modifier al (string _level,uint _score) {
      uint[2] memory u = levRange[_level];
      require(_score >= u[0] && _score <= u[1]);
      _;
  }
  
  modifier lakhani() {
      require(msg.sender == manager);
      _;
  }
  
  mapping (string => uint[2]) levRange;
 
  constructor() public {
      manager = msg.sender;
      
      levRange["Level 1"] = [1,50];
      levRange["Level 2"] = [51,100];
  }

  mapping(string => User[]) userAccess;
  string[2] levels = ["Level 1", "Level 2"];
  
  
  function setuser(string _name, uint _score) public {
      User memory newUser;
      
        newUser.name = _name;
        newUser.score = _score;
      if(_score>=1 && _score<=50){
          userAccess[levels[0]].push(newUser);
       
      }
      else if(_score>=51 &&_score<=100){
            userAccess[levels[1]].push(newUser);
      }

    }
    event logUser(string, uint);
    function getUserByRangelog(string _level, uint _score) public al(_level, _score) lakhani returns(string, uint) {
        User[] memory u = userAccess[_level];
        
        for (uint i=0;i<u.length;i++) {
            if (u[i].score <= _score){
            
            emit logUser(u[i].name, u[i].score);
            }
            
        }
 
}
}