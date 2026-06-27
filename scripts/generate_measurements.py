#!/usr/bin/env python3
import random
import sys
from pathlib import Path

STATIONS = [
    "Abha", "Abidjan", "Abéché", "Accra", "Addis Ababa", "Adelaide", "Aden", "Ahvaz",
    "Albuquerque", "Alexandra", "Alexandria", "Algiers", "Alice Springs", "Almaty", "Amsterdam",
    "Anadyr", "Anchorage", "Andorra la Vella", "Ankara", "Antananarivo", "Antsiranana",
    "Arkhangelsk", "Ashgabat", "Asmara", "Assab", "Astana", "Athens", "Atlanta", "Auckland",
    "Austin", "Baghdad", "Baguio", "Baku", "Baltimore", "Bamako", "Bangkok", "Bangui",
    "Banjul", "Barcelona", "Bata", "Batumi", "Beijing", "Beirut", "Belgrade", "Belize City",
    "Benghazi", "Bergen", "Berlin", "Bilbao", "Birao", "Bishkek", "Bissau", "Blantyre",
    "Bloemfontein", "Boise", "Bordeaux", "Bosaso", "Boston", "Bouaké", "Bratislava", "Brazzaville",
    "Bridgetown", "Brisbane", "Brussels", "Bucharest", "Budapest", "Bujumbura", "Bulawayo",
    "Burnie", "Busan", "Cabo San Lucas", "Cairns", "Cairo", "Calgary", "Canberra", "Cape Town",
    "Changsha", "Charlotte", "Chiang Mai", "Chicago", "Chihuahua", "Chittagong", "Chongqing",
    "Christchurch", "City of San Marino", "Colombo", "Columbus", "Conakry", "Copenhagen", "Cotonou",
    "Cracow", "Da Lat", "Da Nang", "Dakar", "Dallas", "Damascus", "Dar es Salaam", "Darwin",
    "Denpasar", "Denver", "Detroit", "Dhaka", "Dikson", "Dili", "Djibouti", "Dodoma", "Dolisie",
    "Douala", "Dubai", "Dublin", "Dunedin", "Durban", "Dushanbe", "Edinburgh", "Edmonton",
    "Erbil", "Erzurum", "Fairbanks", "Fianarantsoa", "Flores", "Frankfurt", "Fresno", "Gangtok",
    "Garissa", "Garoua", "George Town", "Ghanzi", "Gjoa Haven", "Guadalajara", "Guangzhou", "Guatemala City",
    "Halifax", "Hamburg", "Hamilton", "Hanga Roa", "Hanoi", "Harare", "Harbin", "Hargeisa",
    "Hat Yai", "Havana", "Helsinki", "Heraklion", "Hiroshima", "Ho Chi Minh City", "Hobart", "Hong Kong",
    "Honiara", "Honolulu", "Houston", "Ifrane", "Indianapolis", "Iqaluit", "Irkutsk", "Istanbul",
    "Izmir", "Jacksonville", "Jakarta", "Jayapura", "Jerusalem", "Johannesburg", "Jos", "Juba",
    "Kabul", "Kampala", "Kandi", "Kankan", "Kano", "Kansas City", "Karachi", "Karonga",
    "Kathmandu", "Khartoum", "Kingston", "Kinshasa", "Kolkata", "Kuala Lumpur", "Kumasi", "Kunming",
    "Kuopio", "Kuwait City", "Kyiv", "Kyoto", "La Ceiba", "La Paz", "Lagos", "Lahore", "Lake Havasu City",
    "Lake Tekapo", "Las Palmas de Gran Canaria", "Las Vegas", "Launceston", "Lhasa", "Libreville", "Lisbon",
    "Livingstone", "Ljubljana", "Lodwar", "Lomé", "London", "Los Angeles", "Louisville", "Luanda",
    "Lubumbashi", "Lusaka", "Luxembourg City", "Lviv", "Lyon", "Madrid", "Mahajanga", "Makassar",
    "Makurdi", "Malabo", "Malé", "Managua", "Manama", "Mandalay", "Mango", "Manila", "Maputo",
    "Marrakesh", "Marseille", "Maun", "Medan", "Mek'ele", "Melbourne", "Memphis", "Mexicali",
    "Mexico City", "Miami", "Milan", "Milwaukee", "Minneapolis", "Minsk", "Mogadishu", "Mombasa",
    "Monaco", "Moncton", "Monterrey", "Montreal", "Moscow", "Mumbai", "Murmansk", "Muscat",
    "Mzuzu", "N'Djamena", "Naha", "Nairobi", "Nakhon Ratchasima", "Napier", "Napoli", "Nashville",
    "Nassau", "Ndola", "New Delhi", "New Orleans", "New York City", "Ngaoundéré", "Niamey", "Nicosia",
    "Niigata", "Nouadhibou", "Nouakchott", "Novosibirsk", "Nuuk", "Odesa", "Odienné", "Oklahoma City",
    "Omaha", "Oranjestad", "Oslo", "Ottawa", "Ouagadougou", "Ouahigouya", "Ouarzazate", "Oulu",
    "Palembang", "Palermo", "Palm Springs", "Palmerston North", "Panama City", "Parakou", "Paris", "Perth",
    "Petropavlovsk-Kamchatsky", "Philadelphia", "Phnom Penh", "Phoenix", "Pittsburgh", "Podgorica", "Pointe-Noire",
    "Pontianak", "Port Moresby", "Port Sudan", "Port Vila", "Port-Gentil", "Portland", "Prague", "Praia",
    "Pretoria", "Pyongyang", "Rabat", "Rangpur", "Reggane", "Reykjavík", "Riga", "Riyadh", "Rome",
    "Roseau", "Rostov-on-Don", "Sacramento", "Saint Petersburg", "Saint-Pierre", "Salt Lake City", "San Antonio",
    "San Diego", "San Francisco", "San Jose", "San José", "San Juan", "San Salvador", "Sana'a", "Santo Domingo",
    "Sapporo", "Sarajevo", "Saskatoon", "Seattle", "Ségou", "Seoul", "Seville", "Shanghai", "Singapore",
    "Skopje", "Sochi", "Sofia", "Sokoto", "Split", "St. John's", "St. Louis", "Stockholm", "Surabaya",
    "Suva", "Suwałki", "Sydney", "Tabora", "Tabriz", "Taipei", "Tallinn", "Tamale", "Tamanrasset",
    "Tampa", "Tashkent", "Tauranga", "Tbilisi", "Tegucigalpa", "Tehran", "Tel Aviv", "Thessaloniki",
    "Thiès", "Tijuana", "Timbuktu", "Tirana", "Toamasina", "Tokyo", "Toledo", "Toronto", "Tripoli",
    "Tromsø", "Tucson", "Tunis", "Ulaanbaatar", "Upington", "Ürümqi", "Vaduz", "Valencia", "Valletta",
    "Vancouver", "Veracruz", "Vienna", "Vientiane", "Villahermosa", "Vilnius", "Virginia Beach", "Vladivostok",
    "Warsaw", "Washington", "Wellington", "Whitehorse", "Wichita", "Willemstad", "Winnipeg", "Wrocław",
    "Xi'an", "Yakutsk", "Yangon", "Yaoundé", "Yellowknife", "Yerevan", "Yinchuan", "Zagreb", "Zanzibar City", "Zürich"
]

# Approximate station mean temperatures, deterministic for stable datasets.
_rng = random.Random(42)
MEANS = {station: _rng.uniform(-15.0, 35.0) for station in STATIONS}


def main() -> None:
    rows = int(sys.argv[1]) if len(sys.argv) > 1 else 1_000_000
    out = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("measurements.txt")
    rng = random.Random(1)

    with out.open("w", encoding="utf-8", buffering=1024 * 1024) as f:
        for i in range(rows):
            station = rng.choice(STATIONS)
            temp = round(rng.gauss(MEANS[station], 10.0), 1)
            temp = max(-99.9, min(99.9, temp))
            f.write(f"{station};{temp:.1f}\n")
            if rows >= 10_000_000 and i and i % 10_000_000 == 0:
                print(f"generated {i:,} rows", file=sys.stderr)

    print(f"wrote {rows:,} rows to {out}", file=sys.stderr)


if __name__ == "__main__":
    main()
