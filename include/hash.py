# Import hashlib library (md5 method is part of it)
import hashlib   
from sys import argv

script, file_name = argv 

# Open,close, read file and calculate MD5 on its contents 
with open(file_name) as file_to_check:
    # read contents of the file
    data = file_to_check.read()    
    # pipe contents of the file through
    md5 = hashlib.md5(data).hexdigest()
	
# Open,close, read file and calculate SHA1 on its contents 
with open(file_name) as file_to_check:
    # read contents of the file
    data = file_to_check.read()    
    # pipe contents of the file through
    sha1 = hashlib.sha1(data).hexdigest()

print "MD5 Checksum:"
print md5
print "SHA1 Checksum:"
print sha1