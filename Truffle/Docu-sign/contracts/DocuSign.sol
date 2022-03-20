// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract UserSign {

  //address owner;

  struct signature{
    bool exists;
    bool signed;
    string timestamp;
  }
  struct own{
    bool exists;
    address owner_address;
  }
  mapping(bytes32 => mapping(address => signature)) docuSigns;
  mapping(bytes32 => address[]) signers;
  mapping(bytes32 => own) owner;

  /*
  mapping(bytes32 => address[]) to_sign;
  mapping(bytes32 => bool) signed;

  //Cosas de verificacion de identidad
  mapping(address => bool) user_verified;
  mapping(address => bytes32) user_codes;

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  constructor() public{
    owner = msg.sender;
  }
  */

  //Add user to sign a document
  function inviteUser(bytes32 documentHash, address user) public returns(address u) {
    //Push retorna el nuevo largo del arreglo
    /*
    to_sign[documentHash].push(user);
    */
    if(owner[documentHash].exists && msg.sender != owner[documentHash].owner_address){
      //Sender not owner of the document
      revert("Trying to own an already owned document");
    }else if(owner[documentHash].exists && msg.sender == owner[documentHash].owner_address){
      //Document exists and sender is the owner
      if(docuSigns[documentHash][user].exists){
        //User already requested to sign
        revert("This user has been already requested to sign");
      }else{
        //New user
        docuSigns[documentHash][user].exists=true;
        docuSigns[documentHash][user].signed=false;
        signers[documentHash].push(user);
        return(user);
      }
    }else{
      //First time adding users to sign this document
      owner[documentHash].exists=true;
      owner[documentHash].owner_address=msg.sender;
      docuSigns[documentHash][user].exists=true;
      docuSigns[documentHash][user].signed=false;
      signers[documentHash].push(user);
      return(user);
    }
  }

  //Sign a document
  function signDocument(bytes32 documentHash, string memory time) public returns(bool success){
    /*
    if (msg.sender != to_sign[documentHash]) {
      revert();
    }
    signed[documentHash] = true;
    */
    if (!docuSigns[documentHash][msg.sender].exists || docuSigns[documentHash][msg.sender].signed) {
      revert("The signature was already made or doesnt exist");
    }
    docuSigns[documentHash][msg.sender].signed=true;
    docuSigns[documentHash][msg.sender].timestamp=time;
    return(true);
  }

  //Check signature of a user
  function checkSignature(bytes32 documentHash, address user) public view returns(string memory result) {
    if (!docuSigns[documentHash][user].exists) {
      //Sign not requested for this
      return("Wrong document, this user has not been asked to sign it");
    }else if(docuSigns[documentHash][user].signed){
      //Document signed, return timestamp
      return(docuSigns[documentHash][user].timestamp);
    }else{
      //Signature requested but not signed yet
      return("Not signed yet");
    }
  }

  //Return every signer given a document
  function allSigners(bytes32 documentHash) public view returns(address[] memory all_signers){
    if(owner[documentHash].exists && msg.sender != owner[documentHash].owner_address){
      revert("This document is owned by other user");
    }else{
      return(signers[documentHash]);
    }
  }

  /*
  //This part does the identity verification
  function addUser(address user, bytes32 hashed_verification) public onlyOwner {
    user_verified[user] = false;
    user_codes[user] = hashed_verification;
  }

  function verify(bytes memory verification_code) public {
    if (user_verified[msg.sender] == false && sha256(verification_code) == user_codes[msg.sender]) {
      user_verified[msg.sender] = true;
    }
  }
  */
}