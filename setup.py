from setuptools import setup

setup(
    name='scraping',
    version='1.0',
    packages=[''],
    url='https://github.com/acostasg/scraping',
    license='Database released under Open Database License, individual contents under Database Contents License.',
    author='albert.costas',
    author_email='acostasg@uoc.edu',
    description='UOC practica 1. Tipologia i cicle de vida.  ',
    install_requires=[
        'BeautifulSoup',
        'requests',
        'urllib3',
        'scandir'
    ],
)
