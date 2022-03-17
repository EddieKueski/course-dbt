select 

char_length(zipcode) 

from {{ ref('int_usa_addresses') }}


WHERE char_length(zipcode)  <> 5


