;; Enhanced BitStack Analytics Contract
;; Advanced DeFi analytics with multi-tier staking, governance, and emergency features

;; Constants
(define-constant contract-owner tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u1000))
(define-constant ERR-INVALID-PROTOCOL (err u1001))
(define-constant ERR-INVALID-AMOUNT (err u1002))
(define-constant ERR-INSUFFICIENT-STX (err u1003))
(define-constant ERR-COOLDOWN-ACTIVE (err u1004))
(define-constant ERR-NO-STAKE (err u1005))
(define-constant ERR-BELOW-MINIMUM (err u1006))
(define-constant ERR-PAUSED (err u1007))

;; Define platform token
(define-fungible-token ANALYTICS-TOKEN)

;; Contract Status
(define-data-var contract-paused bool false)
(define-data-var emergency-mode bool false)

;; Staking Configuration
(define-data-var stx-pool uint u0)
(define-data-var base-reward-rate uint u500) ;; 5% base rate (100 = 1%)
(define-data-var bonus-rate uint u100) ;; 1% bonus for longer staking
(define-data-var minimum-stake uint u1000000) ;; Minimum stake amount
(define-data-var cooldown-period uint u1440) ;; 24 hour cooldown in blocks

;; Governance
(define-map Proposals
    uint  ;; proposal-id
    {
        creator: principal,
        description: (string-utf8 256),
        start-block: uint,
        end-block: uint,
        executed: bool,
        votes-for: uint,
        votes-against: uint,
        minimum-votes: uint
    }
)

(define-data-var proposal-count uint u0)

;; Enhanced Data Maps
(define-map UserPositions
    principal
    {
        total-collateral: uint,
        total-debt: uint,
        health-factor: uint,
        last-updated: uint,
        stx-staked: uint,
        analytics-tokens: uint,
        voting-power: uint,
        tier-level: uint,
        rewards-multiplier: uint
    }
)

(define-map StakingPositions
    principal
    {
        amount: uint,
        start-block: uint,
        last-claim: uint,
        lock-period: uint,
        cooldown-start: (optional uint),
        accumulated-rewards: uint
    }
)

(define-map TierLevels
    uint  ;; tier level
    {
        minimum-stake: uint,
        reward-multiplier: uint,
        features-enabled: (list 10 bool)
    }
)

;; Initialize contract
(define-public (initialize-contract)
    (begin
        (asserts! (is-eq tx-sender contract-owner) ERR-NOT-AUTHORIZED)
        
        ;; Set up tier levels
        (map-set TierLevels u1 
            {
                minimum-stake: u1000000,  ;; 1M uSTX
                reward-multiplier: u100,  ;; 1x
                features-enabled: (list true false false false false false false false false false)
            })
        (map-set TierLevels u2
            {
                minimum-stake: u5000000,  ;; 5M uSTX
                reward-multiplier: u150,  ;; 1.5x
                features-enabled: (list true true true false false false false false false false)
            })
        (map-set TierLevels u3
            {
                minimum-stake: u10000000, ;; 10M uSTX
                reward-multiplier: u200,  ;; 2x
                features-enabled: (list true true true true true false false false false false)
            })
        (ok true)
    )
)