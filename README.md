# garak, functional tap.TAP


[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Tests/Linux](https://github.com/NVIDIA/garak/actions/workflows/test_linux.yml/badge.svg)](https://github.com/NVIDIA/garak/actions/workflows/test_linux.yml)
[![Tests/Windows](https://github.com/NVIDIA/garak/actions/workflows/test_windows.yml/badge.svg)](https://github.com/NVIDIA/garak/actions/workflows/test_windows.yml)
[![Tests/OSX](https://github.com/NVIDIA/garak/actions/workflows/test_macos.yml/badge.svg)](https://github.com/NVIDIA/garak/actions/workflows/test_macos.yml)
[![Documentation Status](https://readthedocs.org/projects/garak/badge/?version=latest)](http://garak.readthedocs.io/en/latest/?badge=latest)
[![arXiv](https://img.shields.io/badge/cs.CL-arXiv%3A2406.11036-b31b1b.svg)](https://arxiv.org/abs/2406.11036)
[![discord-img](https://img.shields.io/badge/chat-on%20discord-yellow.svg)](https://discord.gg/uVch4puUCs)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/garak)](https://pypi.org/project/garak)
[![PyPI](https://badge.fury.io/py/garak.svg)](https://badge.fury.io/py/garak)
[![Downloads](https://static.pepy.tech/badge/garak)](https://pepy.tech/project/garak)
[![Downloads](https://static.pepy.tech/badge/garak/month)](https://pepy.tech/project/garak)


<hr>

## install:

`garak` is a command-line tool. It's developed in Linux and OSX.

### standard install with `pip`

Just grab it from PyPI and you should be good to go:

```
python -m pip install -U garak
```

### install this TAP specific version with `pip`

The standard pip version of `garak` does not have a working tap.TAP probe. To get this version that does, try:

```
python -m pip install -U git+https://github.com/NVIDIA/garak.git@main
```

### cool things to add

some useful stuff (nvidia drivers for ec2 instances)

```
nvidia
```

## Examples

Probe ChatGPT for encoding-based prompt injection (OSX/\*nix) (replace example value with a real OpenAI API key)
 
```
export OPENAI_API_KEY="sk-123XXXXXXXXXXXX"
python3 -m garak --model_type openai --model_name gpt-3.5-turbo --probes encoding
```

See if the Hugging Face version of GPT2 is vulnerable to DAN 11.0

```
python3 -m garak --model_type huggingface --model_name gpt2 --probes dan.Dan_11_0
```


## Reading the results

For each probe loaded, garak will print a progress bar as it generates. Once generation is complete, a row evaluating that probe's results on each detector is given. If any of the prompt attempts yielded an undesirable behavior, the response will be marked as FAIL, and the failure rate given.

Here are the results with the `encoding` module on a GPT-3 variant:
![alt text](https://i.imgur.com/8Dxf45N.png)

And the same results for ChatGPT:
![alt text](https://i.imgur.com/VKAF5if.png)

We can see that the more recent model is much more susceptible to encoding-based injection attacks, where text-babbage-001 was only found to be vulnerable to quoted-printable and MIME encoding injections.  The figures at the end of each row, e.g. 840/840, indicate the number of text generations total and then how many of these seemed to behave OK. The figure can be quite high because more than one generation is made per prompt - by default, 10.

Errors go in `garak.log`; the run is logged in detail in a `.jsonl` file specified at analysis start & end. There's a basic analysis script in `analyse/analyse_log.py` which will output the probes and prompts that led to the most hits.

Send PRs & open issues. Happy hunting!

## REST generator
`rest.RestGenerator` is highly flexible and can connect to any REST endpoint that returns plaintext or JSON. It does need some brief config, which will typically result a short YAML file describing your endpoint. See https://reference.garak.ai/en/latest/garak.generators.rest.html for examples.
## Intro to tap.TAP

## Logging

`garak` generates multiple kinds of log:
* A log file, `garak.log`. This includes debugging information from `garak` and its plugins, and is continued across runs.
* A report of the current run, structured as JSONL. A new report file is created every time `garak` runs. The name of this file is output at the beginning and, if successful, also at the end of the run. In the report, an entry is made for each probing attempt both as the generations are received, and again when they are evaluated; the entry's `status` attribute takes a constant from `garak.attempts` to describe what stage it was made at.
* A hit log, detailing attempts that yielded a vulnerability (a 'hit')

## FAQ

They have an FAQ [here](https://github.com/NVIDIA/garak/blob/main/FAQ.md). If you have questions about this specific version, you can also ask me. [wailmerrrr@gmail.com](mailto:wailmerrrr@gmail.com)

Code reference documentation is at [garak.readthedocs.io](https://garak.readthedocs.io/en/latest/).

## Citing garak

You can read the [garak preprint paper](garak-paper.pdf). If you use garak, please cite them.

```
@article{garak,
  title={{garak: A Framework for Security Probing Large Language Models}},
  author={Leon Derczynski and Erick Galinkin and Jeffrey Martin and Subho Majumdar and Nanna Inie},
  year={2024},
  howpublished={\url{https://garak.ai}}
}
```

<hr>

_"God of Lies? If you wish. What society can exist without lies?"_ - Loki Laufeyson

For updates and news see [@garak_llm](https://twitter.com/garak_llm)

© 2023- Leon Derczynski; Apache license v2, see [LICENSE](LICENSE)
