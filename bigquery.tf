  
resource "google_bigquery_dataset_access" "access" {
  dataset_id    = google_bigquery_dataset.dataset.dataset_id
  role          = "roles/bigquery.dataEditor"
  user_by_email = "eletuabdulakeem@gmail.com"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "v_media_dataset"
}
    
