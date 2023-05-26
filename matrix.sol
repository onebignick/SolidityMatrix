// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Matrix {
    function add (uint[][] memory a, uint[][] memory b) public pure returns (uint[][] memory) {
        uint[][] memory c = new uint[][](a.length);
        for (uint i=0; i < a.length; i++) {
            c[i] = new uint[](a[i].length);
            for (uint j=0; j < a[0].length; j++) {
                c[i][j] = a[i][j] + b[i][j];
            }
        }
        return c;
    }

    function sub (uint[][] memory a, uint[][] memory b) public pure returns (uint[][] memory) {
        uint[][] memory c = new uint[][](a.length);
        for (uint i=0; i < a.length; i++) {
            c[i] = new uint[](a[i].length);
            for (uint j=0; j < a[0].length; j++) {
                c[i][j] = a[i][j] - b[i][j];
            }
        }
        return c;
    }

    function transpose (uint[][] memory a) public pure returns (uint[][] memory) {
        uint[][] memory b = new uint[][](a[0].length);
        for (uint i=0; i<a[0].length; i++) {
            b[i] = new uint[](a.length);
            for (uint j=0; j<a.length; j++) {
                b[i][j] = a[j][i];
            }
        }
        return b;
    }

    function dot (uint[][] memory a, uint[][] memory b) public pure returns (uint[][] memory) {
        uint[][] memory tb = transpose(b);
        uint[][] memory c = new uint[][](a.length);
        for (uint i=0; i<a.length; i++) {
            c[i] = new uint[](tb.length);
            for (uint j=0; j<tb.length; j++) {
                uint cur = 0;
                for (uint k=0; k<a[0].length; k++) {
                    cur += (a[i][k] * tb[j][k]);
                }
                c[i][j] = cur;
            }
        }
        return c;
    }
}
