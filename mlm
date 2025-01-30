// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


library SafeMath {
   
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }
 
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}


library Address {
    
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

   
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


library SafeERC20 {

    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }


    function _callOptionalReturn(IERC20 token, bytes memory data) private {
    
        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}



contract MLM {

    using SafeERC20 for IERC20;
    using SafeMath for uint256;
    IERC20 public depositToken;

    address public AdminAddress;
     address public stakeAddress;
    uint public lastUserId;
    uint public contractAmount;

    mapping(address => User) public users;
    mapping(uint => address) public idToAddress;
    mapping(address => address[]) public userref;
    mapping (address => User[]) public referrals;
    mapping(uint256 => uint) public levelPrice;
    mapping(address => uint) public directIncome;
    mapping(address => uint) public levelIncome;

    mapping(address => UserTime) public userstime;

    struct UserTime {
        uint datetime;
    }

    struct User {
        uint id;
        address referrer;
        uint amount;
        bool exists; 
        uint datetime;
    }

    modifier onlyContractOwner() { 
        require(msg.sender == AdminAddress, "onlyOwner"); 
        _; 
    }

    constructor(address _AdminAddress, IERC20 _depositTokenAddress,
     address _stakeAddress)  {
        AdminAddress = _AdminAddress;
        depositToken = _depositTokenAddress;
        stakeAddress = _stakeAddress;

        User memory user = User({
            id: 1,
            referrer: address(0),
            amount:0,
            exists: true,
            datetime:block.timestamp
        });
        users[_AdminAddress] = user;
        idToAddress[1] = _AdminAddress;
        lastUserId = 2;
        for (uint256 i = 2; i <= 25; i++) {
            levelPrice[i] = 0.02e18;
        }
    }




    function AddUserLevel(address[] memory _userAddress,address[] memory _ReferAddress) public onlyContractOwner() {
        for (uint256 i = 0; i < _userAddress.length; i++) {
            require(!isUserExists(_userAddress[i]), "user exists");
            User memory user = User({
                id: lastUserId,
                referrer: _ReferAddress[i],
                exists: true,
                amount: 10000000000000000000,
                datetime: block.timestamp.add(5184000)
            });
            users[_userAddress[i]] = user;
            idToAddress[lastUserId] = _userAddress[i];
            userstime[_userAddress[i]].datetime = block.timestamp.add(5184000);

            contractAmount = contractAmount + 10000000000000000000;
            lastUserId++;
        }
       
    }

    function addamount(address _userAddress,uint amount) public onlyContractOwner() { 
        users[_userAddress].amount = amount;
    }

    function changeReferAddress(address _userAddress,address _referAddress) public onlyContractOwner() {
        users[_userAddress].referrer = _referAddress;
    }


    function AddPlan(address _userAddress, uint levelAmount,uint _days) public  {
        require(isUserExists(_userAddress), "user is not exists. Register first.");
        address _ReferAddress = users[_userAddress].referrer;
        contractAmount = contractAmount + levelAmount;
        userstime[_userAddress].datetime = block.timestamp.add(_days);
        address[] storage userRefs = userref[_userAddress];
        address referrer;

        while (referrer != address(0)) {
            referrer = users[referrer].referrer;
            if(referrer != address(0)) {
                userRefs.push(referrer);
            }
        }
        uint balance = 0;
        uint adminamt = 0;
        for(uint i = 1; i <= userRefs.length; i++) {
            address upline = userref[_userAddress][i-1];
            if(upline == _ReferAddress && _ReferAddress != AdminAddress) {
                uint tokenamount = (levelAmount * 0.5e18)/100e18;
                uint dats = userstime[upline].datetime;
                if(block.timestamp < dats) {
                    depositToken.safeTransferFrom(msg.sender,upline, tokenamount);
                    directIncome[upline] = directIncome[upline].add(tokenamount);
                    balance += tokenamount;
                }
                else {
                    adminamt += tokenamount;
                }
            }
            else if(_ReferAddress == AdminAddress) {
                uint256 tokenamount = (levelAmount * 0.5e18)/100e18;
                adminamt += tokenamount;
                directIncome[AdminAddress] = directIncome[AdminAddress].add(tokenamount);
            }
            else {
                uint256 refAmount = (levelAmount * levelPrice[i])/100e18;
                if(upline == AdminAddress) {
                    adminamt += refAmount;
                }
                if(refAmount > 0 && i <= 6) {
                    uint dats =  userstime[upline].datetime;
                    if(block.timestamp < dats) {
                        depositToken.safeTransferFrom(msg.sender,upline, refAmount);
                        levelIncome[upline] = levelIncome[upline].add(refAmount);
                        balance += refAmount;
                    }
                    else {
                        adminamt += refAmount;
                    }
                }
                else {
                    adminamt += refAmount;
                }
            }
        }
        uint256 remainingBal = levelAmount - balance;
        if(remainingBal > 0) {
            depositToken.safeTransferFrom(msg.sender,AdminAddress, remainingBal);
        }
    }


    function register(address _userAddress, address _ReferAddress, uint levelAmount, uint _days) public {
        require(!isUserExists(_userAddress), "user exists");
        User memory user = User({
            id: lastUserId,
            referrer: _ReferAddress,
            exists: true,
            amount: levelAmount,
            datetime: block.timestamp.add(_days)
        });
        users[_userAddress] = user;
        userstime[_userAddress].datetime = block.timestamp.add(_days);

        contractAmount = contractAmount + levelAmount;

        idToAddress[lastUserId] = _userAddress;
        lastUserId++;

        address[] storage userRefs = userref[_userAddress];
        referrals[_ReferAddress].push(user);

        userRefs.push(_ReferAddress);
        address referrer = _ReferAddress;

        while (referrer != address(0)) {
            referrer = users[referrer].referrer;
            if(referrer != address(0)) {
                userRefs.push(referrer);
            }
        }
        uint balance = 0;
        uint adminamt = 0;
        for(uint i = 1; i <= userRefs.length; i++) {
            address upline = userref[_userAddress][i-1];
            if(upline == _ReferAddress && _ReferAddress != AdminAddress) {
                uint tokenamount = (levelAmount * 0.5e18)/100e18;
                uint dats = userstime[upline].datetime;
                if(block.timestamp < dats) {
                    depositToken.safeTransferFrom(msg.sender,upline, tokenamount);
                    directIncome[upline] = directIncome[upline].add(tokenamount);
                    balance += tokenamount;
                }
                else {
                    adminamt += tokenamount;
                }
            }
            else if(_ReferAddress == AdminAddress) {
                uint256 tokenamount = (levelAmount * 0.5e18)/100e18;
                adminamt += tokenamount;
                directIncome[AdminAddress] = directIncome[AdminAddress].add(tokenamount);
            }
            else {
                uint256 refAmount = (levelAmount * levelPrice[i])/100e18;
                if(upline == AdminAddress) {
                    adminamt += refAmount;
                }
                if(refAmount > 0 && i <= 6) {
                    uint dats =  userstime[upline].datetime;
                    if(block.timestamp < dats) {
                        depositToken.safeTransferFrom(msg.sender,upline, refAmount);
                        levelIncome[upline] = levelIncome[upline].add(refAmount);
                        balance += refAmount;
                    }
                    else {
                        adminamt += refAmount;
                    }
                }
                else {
                    adminamt += refAmount;
                }
            }
        }
        uint256 remainingBal = levelAmount - balance;
        if(remainingBal > 0) {
            depositToken.safeTransferFrom(msg.sender,AdminAddress, remainingBal);
        }
    }


    function addnewAdmin(address _AdminAddress) public onlyContractOwner() {
        AdminAddress = _AdminAddress;
    }


    function usertime(address _user) public view returns(uint) {
        uint times = userstime[_user].datetime;
        return times;
    }
  

    function isUserExists(address user) public view returns (bool) {
        return (users[user].id != 0);
    }


    function withdrawLostTokens(address tokenAddress) public onlyContractOwner() {
        if (tokenAddress == address(0)) {
            payable(AdminAddress).transfer(address(this).balance);
        } else {
            IERC20(tokenAddress).transfer(AdminAddress, IERC20(tokenAddress).balanceOf(address(this)));
        }
    }



    function directreferral(address _userAddress) public view returns(address[] memory) {
        uint ids = users[_userAddress].id;
        address[] memory directReferrals = new address[](lastUserId - ids-1);
        uint256 count = 0;

        for(uint256 i = ids+1; i < lastUserId; i++) {
           address refaddr = idToAddress[i];
           if(users[refaddr].referrer == _userAddress) {
                directReferrals[count] = refaddr;
                count++;
           }
        }
        address[] memory actualReferrals = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            actualReferrals[i] = directReferrals[i];
        }
        return actualReferrals;
    }



}
