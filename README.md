# This task mainly focuses on the smart contract

- I have created a contract called CrowdFunding
- It contains a struct campaign housing all necessary traits
- I want to uniquely identify each campaign based on its ID hence, have implemented a mapping to store the ID's of the campaign to the struct campaign.
- A counter called campaignCount to keep track of number of campaigns

## createCampaign
- A main function called createCampaign, which takes all necessary information and creates a new campaign based on it, and stores in the storage called newCampaign
- Some validations to ensure that _deadline is within limits
- Returns the campaign ID

## donateToCampaign
- This has a payable contraint to ensure that this function can send and receive ETH.
- Here we take the amount of ETH from user and also take the selected campaign based on its ID in the campaign mapping
- Now push this persons address to the donators mapping and his donation to the donations mapping.
- Call the payable and transfer function to transfer the ETH.
- Also update the amountCollected for the selected campaign to ensure the procedure continues.


## getCampaign
- This function is a view function as it doesnt modify any global variables in the contract and only views it.
- It creates a campaign array in memory based on the number of campaigns.
- Then populates this mapping with the campaigns.
- Returns this mapping of campaigns to get all the campaigns.

## getDonators
- This again takes the ID of the campaign.
- Again is a view function to ensure less gas fee.
- It simply returns the donations and donators for that particular campaign.

# Stuff to update
- Need to optimise the contract more to use less gas fee.
- Was not able to deploy the contract as was running into issues with hardhat.

# Learning outcomes
- Learnt a lot about solidity and smart contracts
- Explored remix IDE and hardhat for local development.
