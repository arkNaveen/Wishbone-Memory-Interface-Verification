# Wishbone-Memory-Interface-Verification

        ┌───────────┐
        │ Generator │
        └─────┬─────┘
              │
          gen2driv
              │
              ▼
        ┌───────────┐
        │  Driver   │
        └─────┬─────┘
              │
              ▼
        ┌───────────┐
        │    DUT    │
        └─────┬─────┘
              │
              ▼
        ┌───────────┐
        │  Monitor  │
        └─────┬─────┘
              │
          mon2scb
              │
              ▼
        ┌───────────┐
        │ Scoreboard│
        └───────────┘
