# I4CM workshop

Demonstrate the capabilities of the Test-bed technical infrastructure.

Configured services:

- Kafka & Zookeeper
- Kafka topics UI
- Kafka schema registry and UI
- Admin tool
- After Action Review tool
- Trial-Guidance-Tool
- COPPER COP tool
- LCMS connector / gateway
- Observer Support Tool

## Usage

```console
git clone https://github.com/DRIVER-EU/test-bed.git
cd docker\local-i4cm
docker-compose up -d
```

After you have installed `nodejs` LTS, please initialize the infrastructure with the allowed messages.

```console
git clone https://github.com/DRIVER-EU/example-node-test-bed-adapter
cd example-node-test-bed-adapter
npm i
tsc
node dist/producer.js
```
