erDiagram
    MUSICIAN {
        int Musician_ID PK
        string Name
        string Street
        string City
        string Phone_Number
    }
    INSTRUMENT {
        string Instrument_Name PK
        string Musical_Key
    }
    ALBUM {
        int Album_ID PK
        string Title
        date Copyright_Date
    }
    SONG {
        string Song_Title PK
        string Author
    }

    MUSICIAN ||--o{ INSTRUMENT : Plays
    ALBUM ||--o{ SONG : Contains
    MUSICIAN ||--o{ SONG : Performs
    MUSICIAN ||--o{ ALBUM : Produces

