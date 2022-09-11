  
resource "google_bigquery_dataset_access" "access" {
  dataset_id    = google_bigquery_dataset.dataset.dataset_id
  role          = "roles/bigquery.dataEditor"
  user_by_email = google_service_account.v_media_service_account.email
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "v_media_dataset"
}
    
