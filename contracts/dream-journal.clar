;; Dream Journal Contract

(define-non-fungible-token dream-journal uint)

(define-map dream-data uint {
    owner: principal,
    encrypted-content: (string-utf8 10000),
    timestamp: uint,
    is-shared: bool
})

(define-data-var journal-counter uint u0)

(define-public (create-dream-entry (encrypted-content (string-utf8 10000)))
    (let
        ((journal-id (+ (var-get journal-counter) u1)))
        (try! (nft-mint? dream-journal journal-id tx-sender))
        (map-set dream-data journal-id {
            owner: tx-sender,
            encrypted-content: encrypted-content,
            timestamp: block-height,
            is-shared: false
        })
        (var-set journal-counter journal-id)
        (ok journal-id)))

(define-public (update-dream-entry (journal-id uint) (new-encrypted-content (string-utf8 10000)))
    (let ((entry (unwrap! (map-get? dream-data journal-id) (err u404))))
        (asserts! (is-eq tx-sender (get owner entry)) (err u403))
        (ok (map-set dream-data journal-id (merge entry {
            encrypted-content: new-encrypted-content,
            timestamp: block-height
        })))))

(define-public (share-dream-entry (journal-id uint))
    (let ((entry (unwrap! (map-get? dream-data journal-id) (err u404))))
        (asserts! (is-eq tx-sender (get owner entry)) (err u403))
        (ok (map-set dream-data journal-id (merge entry {
            is-shared: true
        })))))

(define-read-only (get-dream-entry (journal-id uint))
    (ok (unwrap! (map-get? dream-data journal-id) (err u404))))

(define-read-only (get-shared-dreams-count)
    (ok (var-get journal-counter)))

(define-read-only (is-dream-shared (journal-id uint))
    (match (map-get? dream-data journal-id)
        entry (ok (get is-shared entry))
        (err u404)))

