// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract VotingSystem {

  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  mapping(uint => Candidate) public candidates;
  uint[] private candidateIds;
  mapping(address => bool) public voters;
  address public owner;

  modifier onlyOwner() {
    require(msg.sender == owner, "You must be the owner to do this.");
    _;
  } 

  constructor() {
    owner = msg.sender;
  }

  function registerCandidate(string memory _name) public onlyOwner {
    uint _candidateId = candidateIds.length;
    candidates[_candidateId] = Candidate(_candidateId, _name, 0);
    candidateIds.push(_candidateId);
  }

  function vote(uint _candidateId) public {
      require(!voters[msg.sender], "You have already voted");
      require(_candidateId < candidateIds.length, "Candidate with this id does not exist");

      candidates[_candidateId].voteCount++;
      voters[msg.sender] = true;
    }

  function getCandidateCount() public view returns (uint) {
    return candidateIds.length;
  }
}
