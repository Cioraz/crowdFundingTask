// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CrowdFunding {

    // Campaigns main structure
    struct campaign {
        address owner;
        string title;
        string cause;
        string futurePlan;
        // uint256 startDate;
        // uint256 endDate;
        uint256 targetAmount;
        uint256 deadline;
        uint256 amountCollected;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => campaign) public campaigns; // campaignId => campaign

    uint256 public campaignCount = 0;

    // Takes all data from the form and creates a campaign
    // public to make it accessible to everyone
    function createCampaign(address _owner,string memory _title,string memory _cause,string memory _futurePlan,uint256 _deadline,uint256 _targetAmount) public returns(uint256){

        // Creating a new campaign in the storage so that it can be accessed later
        campaign storage newCampaign = campaigns[campaignCount];

        // Validations
        require(newCampaign.deadline < block.timestamp, "Deadline must be in the future");

        // Assigning values to the campaign
        newCampaign.owner = _owner;
        newCampaign.title = _title;
        newCampaign.cause = _cause;
        newCampaign.futurePlan = _futurePlan;
        // newCampaign.startDate = _startDate;
        // newCampaign.endDate = _endDate;
        newCampaign.deadline = _deadline;
        newCampaign.targetAmount = _targetAmount;
        newCampaign.amountCollected = 0;
        campaignCount++;
        return campaignCount-1;
    }

    function donateToCampaign(uint256 _id) public payable{

        // Taking the amount from the user
        uint256 amount = msg.value;


        // Validations
        campaign storage 
        selectedCampaign = campaigns[_id];
        selectedCampaign.donators.push(msg.sender);
        selectedCampaign.donations.push(amount);

        // Sending the amount to the owner
        (bool sent,) = payable(selectedCampaign.owner).call{value: amount}("");
        require(sent, "Failed to send Ether");

        // Updating the amount collected
        if (sent) {
            selectedCampaign.amountCollected += amount;
        }
    }

    // Function to get all the campaigns
    function getCampaigns() public view returns(campaign[] memory){
        campaign[] memory allCampaigns = new campaign[](campaignCount);
        for(uint i =0;i<campaignCount;i++){
            allCampaigns[i] = campaigns[i];
        }
        return allCampaigns;
    }

    // Function to get all donators and their donations to a campaign
    function getDonators(uint256 _id) view public returns (address[] memory,uint256 [] memory){
        return (campaigns[_id].donators,campaigns[_id].donations);
    }

}