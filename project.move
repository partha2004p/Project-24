module MyModule::SecureDocumentNotarization {

    use aptos_framework::signer;

    /// Struct representing a notarized document.
    struct Document has store, key {
        document_hash: vector<u8>,  // Hash of the document for integrity verification
    }

    /// Function to notarize (record) a document by its hash.
    public fun notarize_document(owner: &signer, document_hash: vector<u8>) {
        let document = Document {
            document_hash,
        };
        move_to(owner, document);
    }

    /// Function to verify if a document with the given hash exists.
    public fun verify_document(owner: address, document_hash: vector<u8>): bool acquires Document {
        let document = borrow_global<Document>(owner);
        document.document_hash == document_hash
    }
}
