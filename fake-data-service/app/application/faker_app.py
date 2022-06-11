from fastapi.routing import APIRouter
from faker import Faker
import random


router = APIRouter(prefix='/fake', tags=['fake'])
fake = Faker()


@router.get('/name')
def get_name():
    return {'name': fake.name()}

@router.get('/address')
def get_name():
    return {'address': fake.address()}

@router.get('/simple_profile')
def get_simple_profile():
    return fake.simple_profile()

@router.get('/product_info')
def get_product_info():
    return {
        'name': f'{random.choice([fake.first_name(), fake.job(), fake.city(), fake.country()])}',
        'owner': fake.name()
    }
