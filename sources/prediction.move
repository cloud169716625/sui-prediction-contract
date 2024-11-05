module prediction::prediction {
    use sui::object::UID;
    use sui::tx_context::{ TxContext };
    use std::option::Option;
    use sui::table::{ Table, Self };
    use std::signer;
    // use std::option;
    // use std::signer;
    // use 0x2::Coin;
    // use 0x2::SUI;
    // use 0x1::Transfer;
    // use 0x1::Signer;

    struct Owner has key, store {
        id: UID,               // Required first field for structs with 'key' ability
        owner_address: address // Custom address field
    }

    struct Round has key, store {
        id: UID,
        start_time: u64,
        end_time: u64,
        total_up: u64,
        total_down: u64,
        is_active: bool,
        outcome: Option<bool>, // None until resolved, Some(true) for up, Some(false) for down
        up_payout_rate: u64,
        down_payout_rate: u64,
    }

    struct Bet has key, store {
        id: UID,
        user: address,
        amount: u64,
        prediction: bool, // true for 'up', false for 'down'
        claimed: bool, // Tracks whether user has claimed the reward for this bet
    }

    struct PlatformData has key {
        id: UID,
        rounds: Table<u64, Round>, // Store each round with its id
        bets: Table<u64, vector<Bet>>, // Maps round id to bets in that round
        current_round: u64,
    }

    public fun create_owner(owner_address: address, ctx: &mut TxContext): Owner {
        let id = sui::object::new(ctx);
        Owner { id, owner_address }
    }

    public fun get_owner_address(owner: &Owner): address {
        owner.owner_address
    }

        // Initializes the owner on deployment
    // fun initialize_owner(owner: &signer, ctx: &mut TxContext) {
    //     let id = sui::object::new(ctx);
    //     // Check if an Owner resource already exists at the owner's address
    //     assert!(!exists<Owner>(id, signer::address_of(owner)), 1);
        
    //     // Move the new Owner resource to the owner's address
    //     move_to(owner, Owner { id, address: signer::address_of(owner) });
    // }
    // public fun initialize_owner(owner: &signer) {
    //     // Check if an Owner resource already exists at the owner's address
    //     // assert!(!exists<Owner>(signer::address_of(owner)), 1);
    //     assert!(get_owner_address())        
    //     // Move the new Owner resource to the owner's address
    //     move_to(owner, Owner { address: signer::address_of(owner) });
    // }
}
