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

    function mult (uint[][] memory a , uint b) public pure returns (uint[][] memory) {
        uint[][] memory c = new uint[][](a.length);
        for (uint i=0; i < a.length; i++) {
            c[i] = new uint[](a[i].length);
            for (uint j=0; j < a[0].length; j++) {
                c[i][j] = a[i][j] * b;
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

    function Strassen(uint256[][] memory a, uint256[][] memory b)
        public
        pure
        returns (uint256[][] memory)
    {
        uint256 n = a.length;
        
        require(n == b.length, "Matrix sizes do not match");
        require(n % 2 == 0, "Matrix size must be a power of 2");
        
        uint256[][] memory result = new uint256[][](n);
        for (uint256 i = 0; i < n; i++) {
            result[i] = new uint256[](n);
        }
        
        multiplyMatrixRecursive(a, b, result, 0, 0, 0, 0, n);
        
        return result;
    }
    
    function multiplyMatrixRecursive(
        uint256[][] memory a,
        uint256[][] memory b,
        uint256[][] memory result,
        uint256 aRow,
        uint256 aCol,
        uint256 bRow,
        uint256 bCol,
        uint256 size
    ) private pure {
        if (size == 1) {
            result[aRow][bCol] += a[aRow][aCol] * b[bRow][bCol];
        } else {
            uint256 newSize = size / 2;
            
            // Split matrices into quadrants
            uint256 aRowMid = aRow + newSize;
            uint256 aColMid = aCol + newSize;
            uint256 bRowMid = bRow + newSize;
            uint256 bColMid = bCol + newSize;
            
            // Recursive calls
            multiplyMatrixRecursive(a, b, result, aRow, aCol, bRow, bCol, newSize);
            multiplyMatrixRecursive(a, b, result, aRow, aColMid, bRowMid, bCol, newSize);
            multiplyMatrixRecursive(a, b, result, aRow, aCol, bRow, bColMid, newSize);
            multiplyMatrixRecursive(a, b, result, aRow, aColMid, bRowMid, bColMid, newSize);
            multiplyMatrixRecursive(a, b, result, aRowMid, aCol, bRow, bCol, newSize);
            multiplyMatrixRecursive(a, b, result, aRowMid, aColMid, bRowMid, bCol, newSize);
            multiplyMatrixRecursive(a, b, result, aRowMid, aCol, bRow, bColMid, newSize);
            multiplyMatrixRecursive(a, b, result, aRowMid, aColMid, bRowMid, bColMid, newSize);
        }
    }
}
