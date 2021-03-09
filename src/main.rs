
#[derive(serde::Serialize, serde::Deserialize, PartialEq, Debug)]
struct S {
    a: bool,
    i: i64,
    d: Option<chrono::DateTime<chrono::Utc>>,
    url: Option<url::Url>,
    id: Option<uuid::Uuid>,
}

fn main() {
    tracing_subscriber::fmt::init();
    tracing::info!("start");

    let s = S{
        a: true,
        i: 42,
        d: None,
        url: None,
        id: None,
    };

    let raw = serde_json::to_string(&s).unwrap();
    let recovered: S = serde_json::from_str(&raw).unwrap();

    assert_eq!(s, recovered);

    tracing::info!("done");
}
