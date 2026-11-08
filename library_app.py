import os
import psycopg2
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def borrow_book(member_id: int, book_id: int):
    # Retrieve individual database configuration variables from environment
    db_host = os.getenv("DB_HOST", "localhost")
    db_port = os.getenv("DB_PORT", "5432")
    db_name = os.getenv("DB_NAME")
    db_user = os.getenv("DB_USER")
    db_pass = os.getenv("DB_PASS")
    
    conn = None
    cursor = None
    try:
        # Establish connection using keyword arguments
        conn = psycopg2.connect(
            host=db_host,
            port=db_port,
            dbname=db_name,
            user=db_user,
            password=db_pass
        )
        conn.autocommit = False
        cursor = conn.cursor()

        # 1. Secure parameterized query to inspect book stock
        cursor.execute(
            "SELECT title, available_copies FROM books WHERE book_id = %s FOR UPDATE;",
            (book_id,)
        )
        book = cursor.fetchone()
        
        if not book:
            print(f"❌ Error: Book ID {book_id} does not exist.")
            return

        title, available = book
        if available <= 0:
            print(f"❌ Transaction Denied: '{title}' is currently out of stock.")
            return

        # 2. Parameterized insertion into borrowings
        cursor.execute(
            """
            INSERT INTO borrowings (book_id, member_id, borrow_date, due_date)
            VALUES (%s, %s, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days');
            """,
            (book_id, member_id)
        )

        # 3. Parameterized update for inventory decrement
        cursor.execute(
            "UPDATE books SET available_copies = available_copies - 1 WHERE book_id = %s;",
            (book_id,)
        )

        conn.commit()
        print(f"✅ Success: Member {member_id} successfully borrowed '{title}'.")

    except Exception as error:
        if conn:
            conn.rollback()
        print(f"❌ Transaction rolled back due to error: {error}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == "__main__":
    borrow_book(member_id=3, book_id=4)