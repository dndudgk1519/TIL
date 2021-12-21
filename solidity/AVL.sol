// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;



contract AvlFunction {
    //Node 구조체
    struct Node{
        uint data;
        uint left;  // 왼쪽 자식 노드 값
        uint right;  // 오른쪽 자식 노드 값 
        uint height;
    }

    //data값으로 node를 가져오는 매핑
    mapping (uint =>Node)  treenode;

    event printRoot(uint root);
    event printString(string msg);
    event printHD(uint data, uint height);
    event printTwo(uint data, uint data2);
    event printThree(uint root, uint left, uint right);
    event printheight(uint height);
    event boolcheck(bool value);
    //루트 체크 변수

    uint root;

    // 서브 트리의 높이를 체크하는 함수 
    function _heightCheck(uint _node) internal view returns (uint) {
        if (_node == 0) {
            return 0;

        } else {
            return treenode[_node].height;    
        }
        
    }

    function _max(uint a, uint b) internal pure returns(uint) {
        return a >= b ? a : b;
    }

    function _abs(int a) internal pure returns(int) {
        return a > 0 ? a: -a; 
    }

    //LL(시계방향 회전)
    function _rotateRight(uint _node) internal returns(uint) {
        uint parentNode = _node;   //회전 전 부모노드
        uint childNode = treenode[_node].left; //회전 후 부모노드


        treenode[parentNode].left = treenode[childNode].right;
        treenode[childNode].right = parentNode;

        treenode[parentNode].height = 1 + _max(_heightCheck(treenode[parentNode].left), _heightCheck(treenode[parentNode].right));
        treenode[childNode].height = 1 + _max(_heightCheck(treenode[childNode].left), _heightCheck(treenode[childNode].right));
      
        return childNode;
    }

    //LR(Left회전 후 Right 회전)
    function _rotateLeftRight(uint _node) internal returns(uint) {
        treenode[_node].left = _rotateLeft(treenode[_node].left); 
        return  _rotateRight(treenode[_node].data);
    }

    //RR(시계반대방향 회전)
    function _rotateLeft(uint _node) internal returns(uint) {
        uint parentNode = _node;
        uint childNode = treenode[_node].right;

        treenode[parentNode].right = treenode[childNode].left;
        treenode[childNode].left = parentNode;
        
        treenode[parentNode].height = 1 + _max(_heightCheck(treenode[parentNode].left), _heightCheck(treenode[parentNode].right));
        treenode[childNode].height = 1 + _max(_heightCheck(treenode[childNode].left), _heightCheck(treenode[childNode].right));

        return childNode; 
    }
    
    //RL(Right회전 후 Left회전)
    function _rotateRightLeft(uint _node) internal returns(uint) {
        treenode[_node].right = _rotateRight(treenode[_node].right);
        return _rotateLeft(treenode[_node].data);
    }


    function _insertData(uint _data) public returns (uint) {
        root = _insertNode(root, _data);
        return root;
        
    }


    function _insertNode(uint _node, uint _data) internal returns (uint) {
    
        if (_node == 0) {
            _node = _data;
            treenode[_node] = Node(_data, 0, 0, 0);
        }

        else if (treenode[_node].data == _data) {
            emit printString ("this data already exists");
        }
        
        else if (treenode[_node].data > _data) {
            treenode[_node].left = _insertNode(treenode[_node].left, _data);

            emit printheight(_heightCheck(treenode[_node].left) - _heightCheck(treenode[_node].right));
            if (_abs(int(_heightCheck(treenode[_node].left) - _heightCheck(treenode[_node].right))) == 2) {
                // LL CASE - Right 회전
                if (treenode[treenode[_node].left].data > _data) {
                    _node = _rotateRight(_node);
                    emit printString("LL works");
                }
                // LR CASE - Left 회전 후 Right회전
                else {
                    // _node = _rotateRight(_rotateLeft(_node));
                    _node = _rotateLeftRight(_node);
                    emit printString("LR works");
                }
            }
        }

        else if (treenode[_node].data < _data) {
            treenode[_node].right = _insertNode(treenode[_node].right, _data);
            
            if (_abs(int(_heightCheck(treenode[_node].right) - _heightCheck(treenode[_node].left))) == 2) {
                //RR CASE - Left 회전
                if (treenode[treenode[_node].right].data < _data) {
                    _node = _rotateLeft(_node);
                    emit printString("RR works");
                }
                //RL CASE - Right 회전 후 Left회전
                else {
                    _node = _rotateRightLeft(_node);
                    emit printString("RL works");
                }
            }
        }


        // emit printheight(treenode[_node].height);
        treenode[_node].height = _max(_heightCheck(treenode[_node].left), _heightCheck(treenode[_node].right)) + 1;        
        // emit printThree(treenode[_node].data,treenode[_node].left ,treenode[_node].right);
        // emit printThree(treenode[_node].data, treenode[_node].left, treenode[treenode[_node].left].right);
        return _node;

    }
                
    
    function _deleteData(uint _data) public returns(uint){
        root = _deleteNode(root, _data);
        return root;
    }

    function _deleteNode(uint _node, uint _data) internal returns(uint) {
        //루트노드가 삭제하려는 data와 같은 경우 (으론쪽 서브트리만 존재하는 경우)
        // emit printThree(treenode[_node].data, treenode[treenode[_node].left].data, treenode[treenode[_node].right].data);
        // emit printThree(treenode[_node].data, treenode[treenode[_node].left].data, treenode[treenode[treenode[_node].left].right].data);
        // emit printThree(treenode[_node].data, treenode[treenode[_node].left].data, treenode[treenode[treenode[_node].right].right].data);
        
        if (treenode[_node].data == _data) {
            if (treenode[_node].left == 0) {
                _node = treenode[_node].right;
            emit printString ("work");
                return _node;
            }
        }
        
        if (treenode[_node].data == _data){
            //왼쪽 서브트리에서 최댓값을 찾음 (왼쪽 서브트리만 존재하는 경우)
            uint maxNode = treenode[_node].left;
            emit printString("check point 1");
            emit printTwo(treenode[treenode[_node].left].data, treenode[treenode[treenode[_node].left].right].data);
            while (treenode[_node].right != 0) {
                maxNode = treenode[maxNode].right;
            }
            
            //루트 노드를 왼쪽 서브트리에서 찾은 최대값으로 교체 
            treenode[_node].data = treenode[maxNode].data;
            treenode[_node].left = _deleteNode(treenode[_node].left , maxNode);
            


            //교체 후 높이 확인 & 회전
            if (_abs(int(_heightCheck(treenode[_node].left) - _heightCheck(treenode[_node].right))) == 2) {
                //왼쪽 서브트리가 단일 노드였을 경우 RR Case 1
                emit printheight(_heightCheck(treenode[_node].left) - _heightCheck(treenode[_node].right));
                //왼쪽 서브트리의 높이가 오른쪽 서브트리의 높이보다 작음 RR Case 2
                 if (_heightCheck(treenode[_node].left) < _heightCheck(treenode[_node].right)){
                    _node = _rotateLeft(_node);
                    emit printString("RR works");
                }
                //RL Case
                else {
                    _node = _rotateLeft(_rotateRight(_node));
                    emit printString("RL works");
                }
            }
        }
        //단일 자식 노드 case 종료 -----------------------------------------------
        
        //자식 노드가 2개인 경우 -------------------------------------------------
        //삭제하려는 data값이 루트노드 값보다 작을 경우
        else if (treenode[_node].data > _data) {
            //왼쪽 서브트리에서 최댓값 탐색 후 루트 노드 변경
            treenode[_node].left = _deleteNode(treenode[_node].left, _data);

            //교체 후 불균형 발생
            if (_abs(int(_heightCheck(treenode[_node].right) - _heightCheck(treenode[_node].left))) == 2) {
                emit printString("check point 2");
                //위와 같음 RR case 1
                 if (_heightCheck(treenode[treenode[_node].right].left) < _heightCheck(treenode[treenode[_node].right].right)) {
                    
                    _node = _rotateLeft(_node);
                    emit printString("RR works");
                }
                //RL case
                else {
                    _node = _rotateLeft(_rotateRight(_node));
                    emit printString("RL works");
                }
            }
        
        }
        //삭제하려는 data 값이 더 클 경우 오른쪽 서브트리로 진입해서 탐색
        else if (treenode[_node].data < _data) {
           treenode[_node].right = _deleteNode(treenode[_node].right , _data);
        
        //LL case 1
            if (_abs(int(_heightCheck(treenode[_node].right) - _heightCheck(treenode[_node].left))) == 2) {
                if (int(_heightCheck(treenode[_node].right)) == 0) {
                    _node = _rotateRight(_node);
                emit printString("LL works");
                }
            //LL case 2
                else if (_heightCheck(treenode[treenode[_node].right].left) > _heightCheck(treenode[treenode[_node].right].right)) {
                    _node = _rotateRight(_node);
                emit printString("LL works");
                }

                else {
                    _node = _rotateRight(_rotateLeft(_node));
                emit printString("LR works");
                }
            }
        }  
        //자식노드 2개 case 종료 -------------------------------

         treenode[_node].height = _max(_heightCheck(treenode[_node].left), _heightCheck(treenode[_node].right)) + 1;      
        emit printThree(treenode[_node].data, treenode[treenode[_node].left].data, treenode[treenode[_node].right].data);
        return _node;

    }

function _printThree(uint _node) public {
    require (treenode[_node].data != 0); 
    emit printThree (treenode[_node].data, treenode[treenode[_node].left].data, treenode[treenode[_node].right].data);
    }

function _printTwo(uint _node) public {
    require (treenode[_node].data != 0);
    emit printTwo (treenode[_node].data, treenode[treenode[_node].data].height);
}
}






