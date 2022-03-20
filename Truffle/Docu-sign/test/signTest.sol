// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DocuSign.sol";

contract TestSign {
    // The address of the adoption contract to be tested
    DocuSign docusign = DocuSign(DeployedAddresses.DocuSign());

    //Document hash
    bytes32 docuHash = 0x7465737400000000000000000000000000000000000000000000000000000000;
    //The expected owner of document hash
    address docuOwner = address(this);

    address juan = "0xd02F91Eac302f928EECe57f74553d441A6A3ae0e";
    address edd = "0xe69Eddc2a3D7a589b09fA5faA3fB2237c0889B59";

    // Testing request signatures
    function testUserCanRequestSignatures() public {
        //uint returnedId = adoption.adopt(expectedPetId);
        docusign.inviteUser(docuHash,juan);
        address should_be_juan=docusign.allSigners(docuHash)[0];

        Assert.equal(should_be_juan, juan, "Addresses should be equal.");
    }

    // Testing retrieval of a single pet's owner
    function testSigningDocument() public {
        //address adopter = adoption.adopters(expectedPetId);
        docusign.signDocument(docuHash);

        Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");
    }

    // Testing retrieval of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        // Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
    }
}