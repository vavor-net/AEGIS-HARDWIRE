/*
 * PROJECT: AEGIS-HARDWIRE (HSG-Protocol)
 * AUTHOR: Ahmed Mohamed Abdelmabood
 * ORGANIZATION: VAVOR.NET
 * LICENSE: Apache License 2.0
 * * ANY MODIFICATION OR DISTRIBUTION OF THIS FILE MUST RETAIN THIS HEADER.
 * FOR COMMERCIAL USE, ATTRIBUTION TO THE AUTHOR AND PLATFORM IS MANDATORY.
 * --------------------------------------------------------------------------
 * Module: L3_IMMUTABLE_LOG - Forensic Chain
 */

use sha2::{Sha256, Digest};

pub fn generate_secure_hash(previous_hash: &[u8], current_data: &[u8]) -> Vec<u8> {
    let mut hasher = Sha256::new();
    hasher.update(previous_hash);
    hasher.update(current_data);
    
    // النتيجة يتم تخزينها في الذاكرة المحمية بفيوزات L0
    hasher.finalize().to_vec()
}

pub fn verify_integrity(stored_hash: &[u8], calculated_hash: &[u8]) -> bool {
    // مقارنة مادية سريعة: إذا اختلف بايت واحد، فهذا يعني محاولة اختراق سلوكي
    stored_hash == calculated_hash
}