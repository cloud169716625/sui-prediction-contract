
// #[test_only]
// module prediction::prediction_tests;
// // uncomment this line to import the module
// use prediction::prediction;

// const ENotImplemented: u64 = 0;

// #[test]
// fun test_create_owner() {
//     // pass
// }

// #[test, expected_failure(abort_code = ::hello_world::hello_world_tests::ENotImplemented)]
// fun test_hello_world_fail() {
//     abort ENotImplemented
// }

#[test_only]
module prediction::test_prediction {
    use sui::tx_context;
    use prediction::prediction::{create_owner, get_owner_address};
    use sui::transfer;

    #[test]
    fun test_create_owner() {
        // Initialize the test scenario, which provides a TxContext for testing
        let test_owner_address = @0x1;
        let ctx = tx_context::dummy();

        // Call the create_owner function with the test address and TxContext
        let owner = create_owner(test_owner_address, &mut ctx);

        // Use the getter function to check that the created Owner has the correct owner_address
        let is_correct_address = get_owner_address(&owner) == test_owner_address;
        assert!(is_correct_address, 0); // Assert on the boolean result
        let dummy_address = @0xCAFE;
        transfer::public_transfer(owner, dummy_address);
    }
}
