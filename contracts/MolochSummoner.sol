pragma solidity 0.5.3;

import "./Moloch.sol";
import "./CloneFactory.sol";

contract MolochSummoner is CloneFactory {
    address public template;

    event Summoned(address indexed M, address indexed _summoner);

    constructor (address _template) public {
        template = _template;
    }

    function summonMoloch(
        address _summoner,
        address[] calldata _approvedTokens,
        uint256 _periodDuration,
        uint256 _votingPeriodLength,
        uint256 _gracePeriodLength,
        uint256 _proposalDeposit,
        uint256 _dilutionBound,
        uint256 _processingReward
    ) external returns (Moloch) {
        Moloch M = Moloch(createClone(template));
        M.init(
            _summoner,
            _approvedTokens,
            _periodDuration,
            _votingPeriodLength,
            _gracePeriodLength,
            _proposalDeposit,
            _dilutionBound,
            _processingReward
        );

        emit Summoned(address(M), _summoner);

        return M;
    }
}
