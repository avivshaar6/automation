import requests
import json
import pandas as pd

requests.packages.urllib3.disable_warnings()  # Ignore from requests module warnings

data = pd.read_csv("policy.csv")
NSX_ENDPOINT = "https://nvip.policy.co.il"
HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic YWRtaW46Mm9AMUFuYU4yMDIx',
    'Cookie': 'JSESSIONID=EB39DAA1860B5D91AD8774236C4B551E'
}


def _check_if_services_exists():
    global clean_display_name

    for i in range(0, len(data)):
        service = data.get("Services")[i]
        protocol = data.get("Protocols")[i]
        service_array = service.split(', ')

        if protocol == 'TCP':
            for x in service_array:
                spl = x.split(' ')
                # print(x)
                try:
                    if "[" in spl[1]:
                        try:
                            clean_display_name = spl[1].replace('[', '').replace(']', '')
                            # print(clean_display_name)
                            # print(f"Work on {x} service")

                            url = f"{NSX_ENDPOINT}/policy/api/v1/infra/services/{clean_display_name}-TCP"

                            payload = {}
                            headers = HEADERS

                            response = requests.request("GET", url, headers=headers, data=json.dumps(payload),
                                                        verify=False)
                            result = (response.json())
                            # print(result["display_name"])

                            if result["display_name"] == f"{clean_display_name}-TCP":
                                #     print(result["display_name"])
                                print(f"service {clean_display_name}-TCP is already exist!")

                        except:
                            print(f"Now we create the service: {clean_display_name}-TCP")
                            _create_services(clean_display_name, spl[0], protocol)
                    else:
                        continue

                except:

                    try:
                        url = f"{NSX_ENDPOINT}/policy/api/v1/infra/services/{x}-TCP"

                        payload = {}
                        headers = HEADERS

                        response = requests.request("GET", url, headers=headers, data=json.dumps(payload), verify=False)
                        result = (response.json())
                        # print(result["display_name"])

                        if result["display_name"] == f"{x}-TCP":
                            #     print(result["display_name"])
                            print(f"service {x}-TCP is already exist!")
                    except:
                        print(f"Now we create the service: {x}-TCP")
                        _create_services(x, spl[0], protocol)

        elif protocol == 'UDP':
            for x in service_array:
                spl = x.split(' ')
                # print(x)
                try:
                    if "[" in spl[1]:
                        try:
                            clean_display_name = spl[1].replace('[', '').replace(']', '')
                            # print(clean_display_name)
                            # print(f"Work on {x} service")

                            url = f"{NSX_ENDPOINT}/policy/api/v1/infra/services/{clean_display_name}-UDP"

                            payload = {}
                            headers = HEADERS

                            response = requests.request("GET", url, headers=headers, data=json.dumps(payload),
                                                        verify=False)
                            result = (response.json())
                            # print(result["display_name"])

                            if result["display_name"] == f"{clean_display_name}-UDP":
                                #     print(result["display_name"])
                                print(f"service {clean_display_name}-UDP is already exist!")

                        except:
                            print(f"Now we create the service: {clean_display_name}-UDP")
                            _create_services(clean_display_name, spl[0], protocol)
                    else:
                        continue

                except:

                    try:
                        url = f"{NSX_ENDPOINT}/policy/api/v1/infra/services/{x}-UDP"

                        payload = {}
                        headers = HEADERS

                        response = requests.request("GET", url, headers=headers, data=json.dumps(payload), verify=False)
                        result = (response.json())
                        # print(result["display_name"])

                        if result["display_name"] == f"{x}-UDP":
                            #     print(result["display_name"])
                            print(f"service {x}-UDP is already exist!")
                    except:
                        print(f"Now we create the service: {x}-UDP")
                        _create_services(x, spl[0], protocol)
        else:

            print("Something wrong with the Protocol filed!!!!\nPlease check it!")
            break


def _create_services(service_name, service_number, protocol):
    url = f"{NSX_ENDPOINT}/policy/api/v1/infra/services/{service_name}-{protocol}"

    payload = {
        "display_name": f"{service_name}-{protocol}",
        "service_entries": [
            {
                "resource_type": "L4PortSetServiceEntry",
                "display_name": f"{service_name}",
                "destination_ports": [
                    f"{service_number}"
                ],
                "l4_protocol": f"{protocol}"
            }
        ]
    }
    headers = HEADERS

    response = requests.request("PATCH", url, headers=headers, data=json.dumps(payload), verify=False)


def get_src_groups(data, index: int) -> list:
    src_path = f"/infra/domains/default/groups/{data['Source'][index]}"
    src = src_path.replace(' ', '-')
    return [src]


def get_dst_groups(data, index: int) -> list:
    dst_path = f"/infra/domains/default/groups/{data['Destination'][index]}"
    dst = dst_path.replace(' ', '-')
    return [dst]


def get_services(data, index: int) -> list:
    srv = data['Services'][index]
    return [srv]


def get_protocol(data, index: int) -> str:
    return data['Protocols'][index]


def get_rule(display_name: str, src_groups: list, dst_groups: list, services: list) -> dict:
    rule = {
        "display_name": display_name,
        "source_groups": src_groups,
        "destination_groups": dst_groups,
        "services": services,
        "logged": True,
        "action": "ALLOW"
    }
    return rule


def check_if_section_exists(section_name: str) -> bool:
    url = f"{NSX_ENDPOINT}/policy/api/v1/infra/domains/default/security-policies"
    headers = HEADERS
    payload = {}
    res = requests.request("GET", url, headers=headers, data=json.dumps(payload), verify=False)
    sections = res.json()
    # print(sections)

    for section in sections["results"]:
        # print(section["display_name"])
        asd = section["display_name"]
        if section_name == section["display_name"]:
           # print(f"we found one: ----->{section_name} and {asd}")
            return True
        else:
           # print(f"we still looking: ----->{section_name} and {asd}")
            continue
   # print(f"we don`t found and match: ----->{section_name} and {asd}")
   # print("False")
    return False


def create_rule(display_name: str, rule: dict, section_name: str):
    url = f"{NSX_ENDPOINT}/policy/api/v1/infra/domains/default/security-policies/{section_name}/rules/{display_name}"
    payload = rule
    print(payload)
    headers = HEADERS
    res = requests.request("PATCH", url, headers=headers, data=json.dumps(payload), verify=False)
    # print(f"Section: {dst_url} Succeeded with response code: {res}")
    # return res.json()


def create_section(dst_url: str, display_name: str):
    url = f"{NSX_ENDPOINT}/policy/api/v1/infra/domains/default/security-policies/{dst_url}"
    payload = {
        "display_name": f"{display_name}",
        "category": "Application"
    }
    headers = HEADERS
    res = requests.request("PATCH", url, headers=headers, data=json.dumps(payload), verify=False)
    print(f"Section: {display_name} Succeeded with response code: {res}")
    # return res.json()


def get_services_list(service_array: list, protocol: str) -> list:
    services_array = []
    for x in service_array:
        spl = x.split(' ')
        # print(x)
        try:
            if "[" in spl[1]:
                clean_display_name = spl[1].replace('[', '').replace(']', '')
                # print(f"{clean_display_name}-{protocol}")
                new_service = f"{clean_display_name}-{protocol}"
                services_array.append(new_service)
        # print(services_array) //Print clean services array!!!
        except:
            services_array.append(f"{x}-{protocol}")
    return services_array


def main():
    _check_if_services_exists()
    for i in range(0, len(data)):
        src = data.get("Source")[i]
        dst = data.get("Destination")[i]
        clean_src = src.replace(' ', '_')
        clean_dst = dst.replace(' ', '_')
        srcs = get_src_groups(data=data, index=i)
        dsts = get_dst_groups(data=data, index=i)
        services = get_services(data=data, index=i)
        protocol = get_protocol(data=data, index=i)

        service_array = services[0].split(', ')
        # print(service_array)
        services_list = get_services_list(service_array=service_array, protocol=protocol)
        services_paths = []
        # print(services_list)
        for service in services_list:
            service_path = f"/infra/services/{service}"
            services_paths.append(service_path)

        rule_name = f"{clean_src}-To-{clean_dst}-{i}"

        rule = get_rule(display_name=rule_name, src_groups=srcs, dst_groups=dsts, services=services_paths)
        # print(rule)
        section_exist = check_if_section_exists(section_name=dst)
        # print(section_exist)
        if section_exist:
            print("create a rule.....")
            create_rule(display_name=rule_name, rule=rule, section_name=clean_dst)
            print("finish create a rule.....")
        else:
            print("create a section.....")
            create_section(dst_url=clean_dst, display_name=dst)
            print("finish create a section.....")
            create_rule(display_name=rule_name, rule=rule, section_name=clean_dst)


main()
