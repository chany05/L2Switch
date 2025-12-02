<div align="center">

# 🖧 4-Port Layer 2 Ethernet Switch Design

![Verilog](https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge&logo=verilog)
![Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red?style=for-the-badge)
![FPGA](https://img.shields.io/badge/Target-FPGA-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

<br/>

**A synthesizable hardware implementation of a Layer 2 Ethernet Switch featuring dynamic MAC address learning, aging, and forwarding logic.**

[Project Structure](#-project-structure) •
[Key Features](#-key-features) •
[Architecture](#-architecture) •
[Simulation](#-simulation-results) •
[Getting Started](#-getting-started)

</div>

---

## 📖 Overview

This project implements a **Layer 2 (Data Link Layer) Switch** using Verilog HDL. Unlike a simple hub, this switch intelligently forwards Ethernet frames based on destination MAC addresses, reducing network congestion.

It includes a full **Learning & Aging mechanism**, storing source MAC addresses in a look-up table (CAM/RAM based) and removing them after a timeout period to maintain network efficiency.

## 🚀 Key Features

* **Ethernet Frame Switching**: Supports standard Ethernet frame forwarding between 4 ports.
* **Dynamic MAC Address Learning**: Automatically updates the MAC table with Source MAC addresses from incoming packets.
* **Aging Mechanism**: Periodically removes inactive MAC entries to prevent table overflow (Configurable aging time).
* **Flooding Control**: Broadcasts frames to all ports when the Destination MAC is unknown (DLF - Destination Lookup Failure).
* **Queue Management**: Implements FIFO buffers for each port to handle data rate mismatches.
* **Conflict Resolution**: Round-robin or Priority-based arbitration for simultaneous packet arrivals.

## 🛠️ Tech Stack & Environment

* **Language**: Verilog HDL (IEEE 1364-2005)
* **IDE / Toolchain**: Xilinx Vivado 202x
* **Target Board**: [Insert Board Name, e.g., Digilent Zybo Z7-10 or Basys 3]
* **FPGA Family**: [Insert Family, e.g., Zynq-7000 / Artix-7]

## 🏗️ Architecture

The design consists of the following core modules:

| Module | Description |
| :--- | :--- |
| **`L2Switch_Top`** | Top-level module connecting ports, switching engine, and buffers. |
| **`MAC_Table`** | Stores MAC addresses and port numbers (CAM/RAM implementation). |
| **`Aging_Timer`** | Counts down for each entry and signals removal of stale addresses. |
| **`Switching_Fabric`** | Logic for determining the output port based on lookup results. |
| **`FIFO_Buffer`** | Circular buffer to store packets temporarily during processing. |
| **`Controller`** | FSM (Finite State Machine) managing the overall data flow. |

> **Note**: A block diagram of the architecture can be added here for better visualization.

## 📊 Simulation Results

_Simulation waveforms verifying the Switching, Learning, and Aging processes._

### 1. MAC Learning & Forwarding
![Simulation Waveform 1](https://via.placeholder.com/800x200?text=Insert+Waveform+Here:+Learning+and+Forwarding)
*Description: The switch learns the MAC address from Port 0 and forwards the packet destined for it correctly.*

### 2. Unknown Unicast Flooding
![Simulation Waveform 2](https://via.placeholder.com/800x200?text=Insert+Waveform+Here:+Flooding+Operation)
*Description: Incoming packet with an unknown destination MAC is flooded to all other ports.*

## 📂 Project Structure

```bash
L2Switch/
├── L2Switch.srcs/
│   ├── sources_1/       # Synthesizable RTL source codes (.v)
│   ├── sim_1/           # Simulation testbenches (.v)
│   └── constrs_1/       # Constraint files (.xdc)
├── L2Switch.xpr         # Vivado project file
└── README.md            # Project documentation
