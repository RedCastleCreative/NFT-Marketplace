const {assert} = require ('chai')
const { contracts_build_directory } = require('../truffle-config')

const KryptoBird = artifacts.require('./Kryptobird')

require('chai')
.use(require('chai-as-promised'))
.should()

contract('KryptoBird', (accounts) => {
    let contract
    //make sure to deploy the contract first before running any other tests
    before( async() => {
        contract = await KryptoBird.deployed()
    })

    //this is our 'deployment' container
    describe('deployment', async() => {
        it('deploys successfully', async() => {
            const address = contract.address

            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })

        it('name matches', async() => {
            const theName = await contract.name()
            assert.equal(theName, 'KryptoBird')
        })

        it('symbol matches', async() => {
            const symbol = await contract.symbol()
            assert.equal(symbol, 'KBIRDZ')
        })
    })

    describe('minting', async()=> {
        it('create new tokens/NFTs', async()=> {
            const result = await contract.mint('https...1')
            const totalSupply = await contract.totalSupply()

            assert.equal(totalSupply, 1)
            const event = result.logs[0].args
            //_from and _to is from interface ERC721 (IERC721.sol)
            assert.equal(event._from,'0x0000000000000000000000000000000000000000', 'from the contract')
            //accounts[0] is the contract caller
            assert.equal(event._to, accounts[0], 'to is msg.sender' )


            //for failure
            await contract.mint('https...1').should.be.rejected
        })

    })

    //next, lets test to make sure our indexing is keeping track of things accurately
    describe('indexing', async()=> {
        it('lists NFTs', async() => {
            //lets mint a few more NFTs
            await contract.mint('https...2')
            await contract.mint('https...3')
            await contract.mint('https...4')

            const totalSupply = await contract.totalSupply()


            let result = []
            let KryptoBird
            for (i=1; i<= totalSupply; i++) {
                KryptoBird = await contract.kryptoBirdz(i-1)
                result.push(KryptoBird)
            }
            //assert new array result equals our expected result
            let expected = ['https...1','https...2','https...3','https...4']
            assert.equal(result.join(','), expected.join(','))
        })

    })

})