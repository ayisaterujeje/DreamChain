;; Dream Sharing Contract

(define-map interpretation-requests uint {
    dream-id: uint,
    requester: principal,
    interpreter: (optional principal),
    is-completed: bool
})

(define-data-var request-counter uint u0)

(define-public (request-interpretation (dream-id uint))
    (let
        ((request-id (+ (var-get request-counter) u1)))
        (map-set interpretation-requests request-id {
            dream-id: dream-id,
            requester: tx-sender,
            interpreter: none,
            is-completed: false
        })
        (var-set request-counter request-id)
        (ok request-id)))

(define-public (accept-interpretation-request (request-id uint))
    (let ((request (unwrap! (map-get? interpretation-requests request-id) (err u404))))
        (asserts! (is-none (get interpreter request)) (err u403))
        (ok (map-set interpretation-requests request-id (merge request {
            interpreter: (some tx-sender)
        })))))

(define-public (complete-interpretation (request-id uint))
    (let ((request (unwrap! (map-get? interpretation-requests request-id) (err u404))))
        (asserts! (is-eq (some tx-sender) (get interpreter request)) (err u403))
        (ok (map-set interpretation-requests request-id (merge request {
            is-completed: true
        })))))

(define-read-only (get-interpretation-request (request-id uint))
    (ok (unwrap! (map-get? interpretation-requests request-id) (err u404))))

(define-read-only (get-open-requests)
    (ok (var-get request-counter)))

