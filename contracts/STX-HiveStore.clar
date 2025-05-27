;; StorageSwarm: Enhanced Decentralized Encrypted Cloud Storage Contract

;; title: cloud
;; version:
;; summary:
;; description:
;; Constants
(define-constant contract-owner tx-sender)
(define-constant MIN-STORAGE-FEE u500) ;; Minimum storage fee
(define-constant MAX-STORAGE-FEE u5000) ;; Maximum storage fee
(define-constant storage-fee-per-mb u10) ;; Fee calculation per MB
(define-constant max-file-size u1048576) ;; 1 GB max file size
(define-constant initial-reputation u100)
(define-constant max-reputation u1000)
(define-constant reward-increment u10)
(define-constant penalty-decrement u5)
(define-constant min-replicas u3)
(define-constant max-replicas u10)

;; traits
;;
;; Error Constants (More Descriptive)
(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-FILE-TOO-LARGE (err u101))
(define-constant ERR-INSUFFICIENT-FEE (err u102))
(define-constant ERR-FILE-EXISTS (err u103))
(define-constant ERR-INVALID-INPUT (err u104))
(define-constant ERR-FILE-NOT-FOUND (err u105))
(define-constant ERR-PROVIDER-NOT-REGISTERED (err u106))
(define-constant ERR-INSUFFICIENT-REPUTATION (err u107))
(define-constant ERR-REPLICA-LIMIT-REACHED (err u108))

;; token definitions
;;
;; Storage file metadata structure (Enhanced)
(define-map storage-files 
  { 
    file-id: (buff 32),
    owner: principal 
  }
  {
    file-size: uint,
    encryption-key: (buff 64),
    stored-timestamp: uint,
    total-replicas: uint,
    replica-providers: (list 10 principal)
  }
)

;; constants
;;
;; Enhanced storage providers tracking
(define-map storage-providers 
  principal 
  {
    total-storage: uint,
    successful-storage-ops: uint,
    failed-storage-ops: uint,
    reputation-score: uint,
    last-active-block: uint
  }
)

;; data vars
;;
;; Helper function to cap reputation score
(define-private (cap-reputation-score (current-score uint))
  (if (> current-score max-reputation)
    max-reputation
    current-score)
)

;; data maps
;;
;; Helper function to floor reputation score
(define-private (floor-reputation-score (current-score uint))
  (if (< current-score u0)
    u0
    current-score)
)

;; public functions
;;
;; Input validation functions with more comprehensive checks
(define-private (is-valid-file-id (file-id (buff 32)))
  (and 
    (> (len file-id) u0)  ;; Non-empty
    (<= (len file-id) u32)  ;; Max length check
  )
)

;; read only functions
;;
(define-private (is-valid-encryption-key (key (buff 64)))
  (and 
    (> (len key) u0)  ;; Non-empty
    (<= (len key) u64)  ;; Max length check
  )
)

