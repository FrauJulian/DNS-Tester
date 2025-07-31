# DNS Performance Test Script

This PowerShell script measures DNS query response times for a list of domains and outputs the results into a CSV file along with basic statistics.

## 📋 Table of Contents

* [Parameters](#-parameters)
* [Installation](#-installation)
* [Output](#-output)
* [Statistics](#-statistics)
* [Example](#-example)
* [License](#-license)
* [Author](#-author)

---

## ✅ Requirements

* PowerShell 5.1 or higher
* Read access to a text file containing the list of domains (default: `Domains.txt`)

---

## ⚙️ Parameters

| Parameter           | Type     | Default       | Description                        |
| ------------------- | -------- | ------------- | ---------------------------------- |
| `$DnsServer`        | `string` | `1.1.1.1`     | DNS server to query                |
| `$QueriesPerDomain` | `int`    | `3`           | Number of queries per domain       |
| `$DomainsFile`      | `string` | `Domains.txt` | Path to the text file with domains |
| `$ResultsFile`      | `string` | `Results.csv` | Path for the output CSV file       |

---

## 📥 Installation

1. Download or copy the script into a `.ps1` file.
2. Adjust the parameters (especially file paths) if necessary.
3. Create a `Domains.txt` file in the script directory and list the domains you want to test.

---

## ▶️ Usage

```powershell
.\v1
```

---

## 📄 Output

* **CSV file** (`$ResultsFile`) with columns:

    * `domain` — the queried domain name
    * `query` — the iteration number of the query
    * `response_ms` — response time in milliseconds, or `ERR` if the query failed
* **Console output** showing each query result and final statistics.

---

## 📊 Statistics

At the end of the script run, it prints:

* **Average**: average response time (ms)
* **Shortest**: fastest response time (ms)
* **Longest**: slowest response time (ms)

---

## 📑 Example

```powershell
# Content of Domains.txt:
example.com
microsoft.com

# Execute the script
.\v1.ps1

# Sample console output:
[example.com] Query 1: 23.45 ms
[example.com] Query 2: 22.87 ms
[example.com] Query 3: 24.12 ms
...
==== Stats ====
Average: 23.48 ms
Shortest: 22.87 ms
Longest: 24.12 ms
```

---

## 📝 License

This script is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## 👤 Contributors

- [Julian Lechner - FrauJulian](https://fraujulian.xyz)

---

## 🤝 Enjoy?

Give it a star ⭐ on [github](https://github.com/FrauJulian/DNS-Tester)!

### Greetings from Austria! ⛰️
