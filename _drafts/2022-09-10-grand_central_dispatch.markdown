---
layout: coding_docs
title: Grand Central Dispatch Queue (GCD)
image: 
description: 
duration: 1 hours
date: 2022-09-23
theme-color: 
tags: gcd
---

# Grand Central Dispatch (GCD)

An object that manages the execution of tasks **serially** or **concurrently** on your app's *main thread* or on a *background thread*.

1. Dispatch queues are FIFO (First In First Out) queues to which your application can submit tasks in the form of block objects.
2. Dispatch queues execute tasks either serially or concurrently.
3. Work submitted to dispatch queues executes on a pool of thread managed by the system. Except for the dispatch queue representing your app's main thread, the system makes no guarantees about which thread it uses to execute a task.
4. Attempting to synchronously execute a work item on the main queue results in **deadlock**.
5. Excessive thread creation:
    + When a task scheduled by a concurrent dispatch queue blocks a thread, the system creates additional threads to run other queued concurrent tasks. If too many tasks block, the system may run out of threads for your app.
    + Create too many private concurrent dispatch queues. Instead of creating private concurrent queues, submit tasks to one of the global concurrent dispatch queue. For serial tasks, set the target of the serial queue to one of the global concurrent queue.

> **A context switching** is the process of storing the state for a process or a thread, so that it can be restored and resume execution at a later point, and then restoring a different, previously saved, state.

> **Concurrency** : techniques that make programs more usable (perform multiple tasks simultaneously)

> **Parallelism** : techniques to make programs faster by performing serveral computations at the same time (require hardware with multiple processing units)

### Contents
---
1. [Creating a Dispatch Queue](#creating_dispatch_queue)
2. [Executing Tasks Asynchronously](#execute_async)
3. [Executing Tasks Synchronously](#execute_sync)
4. [Executing a Task in Parallel](#execute_parallel)
5. [Dispatching Work to Groups](#dispatch_groups)
6. [Managing Queue Attributes](#manage_queue_attribute)
7. [Getting and Setting Contextual Data](#create_set_contextual_data)
8. [Managing the Main Dispatch Queue](#managing_main_dispatch_queue)
9. [Scheduling Combine Publishers](#scheduling_combine_publishers)
10. [Instance Methods](#instance_methods)

<h1>Contents</h1>
<h2 id="creating_dispatch_queue">Creating a Dispatch Queue</h2>

```swift 
/*
 + label: a string used to uniquely identify dispatch queue which is useful in debugging tools such as Instruments, sample, stackshots, and crash reports.
 + qos [Quality of Service]: specify the priorities for executing tasks
    (enumeration)
    1. Primary QoS (order from the most interactive to the least interactive)
    ---------------
    - userInteractive : For the most interactive tasks with the user, such as operating on the main thread, refreshing the user interface, or performing animations (look like freeze if not happen quickly). Focuses on responsiveness and performance.
    - userInitiated : For the tasks that needs immediate results, such as opening a saved document or perform user events in UI (complete to continue user interaction). Focuses on responsiveness and performance.
    - utility : For tasks that don't require an immediate results, such as downloading or importing data (typically has progress bar). seconds-minutes-task
    - background : For tasks that do not visible to the user (no user interaction), such as indexing, synchronizing, and backups. Focuses on energy efficiency. minutes-hours-task
    2. Special QoS
    ---------------
    - default : Not intended for developers to classify. The level is between user-initiated and utility. The GCD global queue runs at this level.
    - unspecified : No QoS specified so the system should infer an environmental QoS. If threads use legacy APIs that may opt the thread out of QoS can have an unspecified QoS.
 + attributes: define the behavior of a dispatch queue
    (struct)
    - initiallyInactive
    - concurrent
 + autoreleaseFrequency: a constant indicating the frequency with which a dispatch queue autorelease objects
    (enumeration)
    - inherit : inherit autorelease frequency from its target queue
    - workItem : configure an autorelease pool before the execution of a block, and releases the objects in that pool after the block finishes executing
    - never : no autorelease pool is set up
 + target: redirects all blocks from the current dispatch queue to the specified target queue
 */
 
let targetQueue = DispatchQueue(label: "com.queue.serial")
let dispatchQueue = DispatchQueue(label: "com.queue.example_queue", qos: .background, attributes: .initiallyInactive, autoreleaseFrequency: .workItem, target: targetQueue)
let workItem = DispatchWorkItem(qos: .userInitiated, flags: .inheritQoS) {
    print("Work item is being executed.")
}
dispatchQueue.async(execute: workItem)
dispatchQueue.activate()
```

1. **Main Queue**

```swift 
// main dispatch queue is serial queue
let queueWithMainThread = DispatchQueue.main
print("main label: ", queueWithMainThread.label)
print("main qos: ", queueWithMainThread.qos)
print(queueWithMainThread.isKind(of: OS_dispatch_queue_main.self))
print("main queue is serial queue : ", queueWithMainThread.isKind(of: OS_dispatch_queue_serial.self))
```

2. **Global Queue**

```swift
// global dispatch queue is concurrent queue
let globalQueue = DispatchQueue.global(qos: .background)
print("global label: ", globalQueue.label)
print("global qos: ", globalQueue.qos)
print(globalQueue.isKind(of: OS_dispatch_queue_global.self))
```

3. **Custom Queue**
```swift
// custom queue : serial queue (default), concurrent queue
let customQueue = DispatchQueue(label: "com.custom.concurrent", attributes: .concurrent)
print("custom queue label : ", customQueue.label)
print("custom queue qos : ", customQueue.qos)
print("customQueue is concurrent queue : ", customQueue.isKind(of: OS_dispatch_queue_concurrent.self))
print("customQueue is serial queue : ", customQueue.isKind(of: OS_dispatch_queue_serial.self))
```

```swift
typealias dispatch_queue_main_t = OS_dispatch_queue_main
typealias dispatch_queue_global_t = OS_dispatch_queue_global
typealias dispatch_queue_serial_t = OS_dispatch_queue_serial
typealias dispatch_queue_concurrent_t = OS_dispatch_queue_concurrent
```

<h2 id="execute_async">Executing Tasks Asynchronously</h2>

<h2 id="execute_sync">Executing Tasks Synchronously</h2>

<h2 id="execute_parallel">Executing a Task in Parallel</h2>

<h2 id="dispatch_groups">Dispatching Work to Groups</h2>

<h2 id="manage_queue_attribute">Managing Queue Attributes</h2>

<h2 id="create_set_contextual_data">Getting and Setting Contextual Data</h2>

<h2 id="managing_main_dispatch_queue">Managing the Main Dispatch Queue</h2>

<h2 id="scheduling_combine_publishers">Scheduling Combine Publishers</h2>

<h2 id="instance_methods">Instance Methods</h2>