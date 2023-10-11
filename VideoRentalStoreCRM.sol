// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract VideoRentalStoreCRM {
    struct User {
        uint userId;
        string name;
        uint credit;
        uint[] DVD_IDs;
        uint age;
    }

    User[] users;

    event UserAdded(uint userId, string name, uint credit);
    event CreditWithdrawn(uint userId, uint amountWithdrawn);

    function addUser(
        string memory _name,
        uint _credit,
        uint[] memory _DVD_IDs,
        uint _age
    ) public {
        if (_age < 18) {
            revert("To sign you must be atleast 18");
        }
        uint userId = users.length;

        users.push(
            User({
                userId: userId,
                name: _name,
                credit: _credit,
                DVD_IDs: _DVD_IDs,
                age: _age
            })
        );

        emit UserAdded(userId, _name, _credit);
    }

    function getUser(
        uint _userId
    ) public view returns (uint, string memory, uint, uint[] memory) {
        require(_userId < users.length, "user doesn't exist");
        User memory user = users[_userId];
        return (user.userId, user.name, user.credit, user.DVD_IDs);
    }

    function withdrawCredit(uint _userId, uint _amount) public {
        require(_userId < users.length, "user doesn't exist");
        assert(users[_userId].credit >= _amount);

        users[_userId].credit -= _amount;

        emit CreditWithdrawn(_userId, _amount);
    }
}
