;; Dream Token Contract

(define-fungible-token dream-token)

(define-constant contract-owner tx-sender)
(define-data-var token-oracle principal tx-sender)

(define-public (mint (amount uint) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender (var-get token-oracle)) (err u403))
        (ft-mint? dream-token amount recipient)
    ))

(define-public (transfer (amount uint) (sender principal) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender sender) (err u403))
        (ft-transfer? dream-token amount sender recipient)
    ))

(define-public (set-oracle (new-oracle principal))
    (begin
        (asserts! (is-eq tx-sender contract-owner) (err u403))
        (ok (var-set token-oracle new-oracle))
    ))

(define-read-only (get-balance (account principal))
    (ok (ft-get-balance dream-token account)))

(define-read-only (get-oracle)
    (ok (var-get token-oracle)))

