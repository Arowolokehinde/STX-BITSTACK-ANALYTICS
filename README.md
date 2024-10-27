### STX-BitStack Analytics Contract
## Overview
The STX-BitStack Analytics Contract is a smart contract designed for advanced DeFi analytics, staking, governance, and emergency management within the Stacks blockchain ecosystem. The contract provides a multi-tier staking system that incentivizes long-term STX staking through a system of tier levels, lock periods, and bonus multipliers. It also features a governance module, allowing users with sufficient voting power to propose and vote on important protocol changes. Finally, emergency functions enable contract pausing and resumption to ensure security.

## Features
** 1. Multi-Tier Staking System **
Staking: Users can stake STX and optionally lock it for a set period, which increases the reward multiplier.
Tier Levels: The contract defines three tiers based on the amount staked, each with unique benefits and multipliers.
Cooldown Period: Users can initiate unstaking, which activates a cooldown period to prevent immediate withdrawals, helping stabilize liquidity.
Rewards Calculation: Rewards are calculated based on staked amount, staking tier, and lock period multiplier.

** 2. Governance Module **
Proposal Creation: Users with sufficient voting power can propose changes to the contract.
Voting on Proposals: Users can vote on active proposals, with options to vote “for” or “against.”
Proposal Execution: Proposals with majority votes can be executed, enabling decentralized decision-making.

** 3. Emergency Management **
Contract Pause/Resume: The contract owner can pause or resume the contract in case of emergencies.
Emergency Mode: Additional safety for managing unforeseen risks or securing funds.

## Constants and Parameters
- contract-owner: The address that deployed the contract and has administrative rights.
- Base Reward Rate: The default rate (e.g., 5%) used to calculate staking rewards.
- Bonus Rate: An additional bonus for longer staking lock periods.
- Cooldown Period: Specifies the cooldown period before completing unstake, measured in blocks.
- Tier Levels: Defines the minimum staking requirements and reward multipliers for each tier.

## Key Data Structures
- UserPositions: Records a user’s staking details, collateral, debt, tier level, voting power, and other analytics-related data.
- StakingPositions: Tracks the amount of STX staked, lock period, cooldown period, and accumulated rewards.
- Proposals: Stores governance proposals with metadata like description, start and end block, vote counts, and execution status.
- TierLevels: Defines tier configurations with minimum stake requirements, reward multipliers, and enabled features.
Function Overview

## Staking Functions
(stake-stx (amount uint) (lock-period uint))
- Allows users to stake STX tokens and optionally lock them for a specific period to gain higher rewards.
- Calculates tier level and reward multiplier based on the staking amount and lock period.
(initiate-unstake (amount uint))
- Begins the unstaking process by setting a cooldown period.
- Ensures that no other cooldown is active for the user.
(complete-unstake)
- Finalizes the unstaking after the cooldown period has elapsed.
- Transfers the staked STX back to the user and clears their staking record.
(calculate-rewards (user principal) (blocks uint)) (private)
- Computes the rewards based on the user’s staked amount, tier, and multiplier.
- Can be called by staking functions for reward calculation.

## Governance Functions
- (create-proposal (description (string-utf8 256)) (voting-period uint))
- Allows users with sufficient voting power to create a governance proposal.
- Sets up the proposal with start and end block numbers, and initializes vote counts.

(vote-on-proposal (proposal-id uint) (vote-for bool))
- Allows users to vote on an active proposal.
- Voting power is determined by the user's staked amount, and the votes are recorded in the proposal's metadata.

## Emergency Management Functions
(pause-contract)
- Pauses contract operations during emergencies, preventing functions like staking or unstaking from executing.
(resume-contract)
- Resumes normal operations if the contract is in a paused state.

## Helper Functions
(calculate-lock-multiplier (lock-period uint)) (private)
- Determines the reward multiplier based on the lock period.
- Multiplier options:
2 months: 1.5x
1 month: 1.25x
No lock: 1x
(get-tier-info (stake-amount uint)) (private)
- Retrieves the tier level and corresponding reward multiplier based on the user’s total staked amount.