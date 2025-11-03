"""Test Python highlighting: all major syntax elements."""
import asyncio
from dataclasses import dataclass
from enum import Enum
from typing import Dict, Generic, List, Optional, TypeVar

T = TypeVar('T')

class Status(Enum):
    PENDING = "pending"
    ACTIVE = "active"

@dataclass
class Config:
    host: str
    port: int = 8080
    debug: bool = False

class Cache(Generic[T]):
    _instance_count: int = 0
    
    def __init__(self, max_size: int = 100):
        self._data: Dict[str, T] = {}
        self._max_size = max_size
        self.__private = None
        Cache._instance_count += 1
    
    def __repr__(self) -> str:
        return f"Cache(size={len(self._data)})"
    
    def __len__(self) -> int:
        return len(self._data)
    
    def __getitem__(self, key: str) -> Optional[T]:
        return self._data.get(key)
    
    @property
    def size(self) -> int:
        return len(self._data)
    
    @staticmethod
    def validate(key: str) -> bool:
        return bool(key and key.strip())
    
    @classmethod
    def create_default(cls) -> 'Cache[str]':
        return cls(max_size=50)

async def fetch_data(url: str, timeout: float = 10.0) -> Dict[str, any]:
    async with asyncio.timeout(timeout):
        await asyncio.sleep(0.1)
        return {"status": "ok", "data": [1, 2, 3]}

def process(items: List[int], *, multiplier: int = 2) -> List[int]:
    # Comprehensions
    result = [x * multiplier for x in items if x > 0]
    lookup = {i: v for i, v in enumerate(result)}
    unique = {abs(x) for x in result}
    squared = (x ** 2 for x in result)
    
    # Numeric literals
    hex_val = 0xFF
    oct_val = 0o77
    bin_val = 0b1010
    sci_val = 1e-10
    
    # String variants
    raw = r"C:\path\to\file"
    fstring = f"Count: {len(result):#x}"
    multiline = """line1
    line2"""
    
    # Boolean/None
    is_valid = True
    is_empty = False

    nothing = None
    
    # Operators
    bitwise = hex_val & oct_val | bin_val ^ 0xAA
    comparison = 1 < 2 <= 3 != 4
    logical = True and False or not None
    
    # Built-ins and lambdas
    total = sum(range(10))
    filtered = filter(lambda x: x % 2 == 0, result)
    mapped = map(lambda x: x ** 2, result)
    
    # Exception handling
    try:
        risky = 1 / 0
    except ZeroDivisionError as e:
        print(f"Error: {e}")
    except (ValueError, TypeError):
        pass
    else:
        print("Success")
    finally:
        print("Done")
    
    # Context manager
    with open(__file__, 'r') as f:
        content = f.read()
    
    # Match statement
    match total:
        case 0:
            print("zero")
        case x if x > 100:
            print("large")
        case _:
            print("other")
    
    return result

def decorator(func):
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapper

@decorator
def example(x: int, y: int) -> int:
    return x + y

if __name__ == "__main__":
    config = Config(host="localhost", port=8080, debug=True)
    cache = Cache[int](max_size=10)
    result = process([1, 2, 3, -4, 5], multiplier=3)
    asyncio.run(fetch_data("https://api.example.com"))
