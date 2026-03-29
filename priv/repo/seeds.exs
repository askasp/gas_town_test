# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias GasTownTest.Repo
alias GasTownTest.Electronics.{Component, Pin, ComponentSpec}

# Helper to insert a component with pins and specs
defmodule Seeds do
  def insert_component!(attrs, pins, specs) do
    component =
      %Component{}
      |> Component.changeset(attrs)
      |> Repo.insert!()

    for pin_attrs <- pins do
      %Pin{}
      |> Pin.changeset(Map.put(pin_attrs, :component_id, component.id))
      |> Repo.insert!()
    end

    for spec_attrs <- specs do
      %ComponentSpec{}
      |> ComponentSpec.changeset(Map.put(spec_attrs, :component_id, component.id))
      |> Repo.insert!()
    end

    component
  end
end

# ATtiny85 - 8-pin AVR microcontroller
Seeds.insert_component!(
  %{
    name: "ATtiny85",
    type: "microcontroller",
    description: "8-bit AVR microcontroller with 8KB flash, 512B SRAM, 512B EEPROM",
    package_type: "DIP-8",
    datasheet_url: "https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf"
  },
  [
    %{name: "PB5/RESET/ADC0/dW", number: 1, type: "digital_io", voltage_min: 0.0, voltage_max: 5.5},
    %{name: "PB3/ADC3/XTAL1/OC1B", number: 2, type: "analog_in", voltage_min: 0.0, voltage_max: 5.5},
    %{name: "PB4/ADC2/XTAL2/OC1B", number: 3, type: "analog_in", voltage_min: 0.0, voltage_max: 5.5},
    %{name: "GND", number: 4, type: "ground", voltage_min: 0.0, voltage_max: 0.0},
    %{name: "PB0/MOSI/SDA/AIN0/OC0A", number: 5, type: "pwm", voltage_min: 0.0, voltage_max: 5.5},
    %{name: "PB1/MISO/AIN1/OC0B/OC1A", number: 6, type: "pwm", voltage_min: 0.0, voltage_max: 5.5},
    %{name: "PB2/SCK/SCL/ADC1/T0", number: 7, type: "analog_in", voltage_min: 0.0, voltage_max: 5.5},
    %{name: "VCC", number: 8, type: "power", voltage_min: 2.7, voltage_max: 5.5}
  ],
  [
    %{key: "flash_size", value: "8192", unit: "bytes"},
    %{key: "sram_size", value: "512", unit: "bytes"},
    %{key: "eeprom_size", value: "512", unit: "bytes"},
    %{key: "max_clock_speed", value: "20", unit: "MHz"},
    %{key: "adc_channels", value: "4", unit: nil},
    %{key: "pwm_channels", value: "2", unit: nil},
    %{key: "operating_voltage_min", value: "2.7", unit: "V"},
    %{key: "operating_voltage_max", value: "5.5", unit: "V"}
  ]
)

# Potentiometer - 10kΩ linear taper
Seeds.insert_component!(
  %{
    name: "Potentiometer 10kΩ",
    type: "passive",
    description: "10kΩ linear taper rotary potentiometer, single-turn",
    package_type: "through-hole",
    datasheet_url: nil
  },
  [
    %{name: "CCW", number: 1, type: "analog_in", voltage_min: 0.0, voltage_max: 50.0},
    %{name: "Wiper", number: 2, type: "analog_in", voltage_min: 0.0, voltage_max: 50.0},
    %{name: "CW", number: 3, type: "analog_in", voltage_min: 0.0, voltage_max: 50.0}
  ],
  [
    %{key: "resistance", value: "10000", unit: "Ω"},
    %{key: "taper", value: "linear", unit: nil},
    %{key: "power_rating", value: "0.25", unit: "W"},
    %{key: "tolerance", value: "20", unit: "%"}
  ]
)

# N-Channel MOSFET (2N7000)
Seeds.insert_component!(
  %{
    name: "2N7000",
    type: "active",
    description: "N-channel enhancement mode MOSFET, 60V, 200mA",
    package_type: "TO-92",
    datasheet_url: "https://www.onsemi.com/pdf/datasheet/2n7000-d.pdf"
  },
  [
    %{name: "Source", number: 1, type: "digital_io", voltage_min: 0.0, voltage_max: 60.0},
    %{name: "Gate", number: 2, type: "digital_io", voltage_min: 0.0, voltage_max: 20.0},
    %{name: "Drain", number: 3, type: "digital_io", voltage_min: 0.0, voltage_max: 60.0}
  ],
  [
    %{key: "vds_max", value: "60", unit: "V"},
    %{key: "vgs_threshold", value: "2.1", unit: "V"},
    %{key: "id_continuous", value: "200", unit: "mA"},
    %{key: "rds_on", value: "5", unit: "Ω"},
    %{key: "power_dissipation", value: "400", unit: "mW"}
  ]
)

# LED (standard red 5mm)
Seeds.insert_component!(
  %{
    name: "Red LED 5mm",
    type: "active",
    description: "Standard 5mm red LED, 20mA forward current, 2V forward voltage",
    package_type: "through-hole",
    datasheet_url: nil
  },
  [
    %{name: "Anode", number: 1, type: "digital_io", voltage_min: 0.0, voltage_max: 3.0},
    %{name: "Cathode", number: 2, type: "ground", voltage_min: 0.0, voltage_max: 0.0}
  ],
  [
    %{key: "forward_voltage", value: "2.0", unit: "V"},
    %{key: "forward_current", value: "20", unit: "mA"},
    %{key: "max_forward_current", value: "30", unit: "mA"},
    %{key: "wavelength", value: "620", unit: "nm"},
    %{key: "luminous_intensity", value: "200", unit: "mcd"}
  ]
)

# Resistor (220Ω, common LED current-limiting resistor)
Seeds.insert_component!(
  %{
    name: "Resistor 220Ω",
    type: "passive",
    description: "220Ω carbon film resistor, 1/4W, 5% tolerance",
    package_type: "through-hole",
    datasheet_url: nil
  },
  [
    %{name: "Terminal 1", number: 1, type: "analog_in", voltage_min: 0.0, voltage_max: 250.0},
    %{name: "Terminal 2", number: 2, type: "analog_in", voltage_min: 0.0, voltage_max: 250.0}
  ],
  [
    %{key: "resistance", value: "220", unit: "Ω"},
    %{key: "power_rating", value: "0.25", unit: "W"},
    %{key: "tolerance", value: "5", unit: "%"},
    %{key: "temperature_coefficient", value: "200", unit: "ppm/°C"}
  ]
)
