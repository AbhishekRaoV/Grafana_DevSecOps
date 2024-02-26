import requests

# Jaeger API endpoint
jaeger_url = "http://10.63.32.133:16686/api/traces"

# Service name for which you want to collect response time
service_name = "alert-management"

# Query parameters
query_params = {
    "service": service_name,
    "limit": 1  # You can adjust the limit as needed
}

# Make a request to Jaeger API
response = requests.get(jaeger_url, params=query_params)

# Check if the request was successful
if response.status_code == 200:
    # Parse the response JSON
    traces = response.json().get("data", [])

    # Extract response time from the first trace
    if traces:
        first_trace = traces[0]
        duration = first_trace.get("duration", 0) / 1000000  # Convert duration to seconds
        print(f"Response time for {service_name}: {duration:.2f} seconds")
    else:
        print(f"No traces found for {service_name}")
else:
    print(f"Failed to fetch traces. Status code: {response.status_code}")
