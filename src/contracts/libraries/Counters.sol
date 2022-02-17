// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import './SafeMath.sol';



library Counters {
    using SafeMath for uint256;

    struct Counter {
        uint256 _value;
    }

    //use storage instead of memory - memory will wipe clean once function call is over
    function current(Counter storage counter) internal view returns(uint256) {
        return counter._value;
    }

    //its not possible to overflow 256 bit integer with increments of 1, thus we don't need to use SafeMath (saves gas)
    function increment (Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }

}