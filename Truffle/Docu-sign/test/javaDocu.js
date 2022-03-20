const Signing = artifacts.require("UserSign");

contract("Signing", (accounts) => {
    let sign;
    var owner = accounts[0];
    let expectedSigner;
    var docuHash = "0x7465737400000000000000000000000000000000000000000000000000000000";

    before(async () => {
        sign = await Signing.deployed();
    });

    describe("Request a signature, sign and check signature", async () => {
        before("Request one signature from accounts[1]", async () => {
            await sign.inviteUser(docuHash, accounts[1], { from: accounts[0] });
            expectedSigner = accounts[1];
        });
        
        it("Check if signature was requested", async () => {
            const signers = await sign.allSigners(docuHash, { from: owner });
            assert.equal(signers[0], expectedSigner, "The signer of the document should be the seccond account.");
        });

        it("Check if the document has been signed", async () => {
            await sign.signDocument(docuHash, {from: expectedSigner});
            const signed = await sign.checkSignature(docuHash,accounts[1]);
            assert(signed, "The document should be signed already.");
        });
    });
});